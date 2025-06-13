function predicted_value= import_xlearn_prediction_SWA(filename, startRow, endRow)
%IMPORTFILE1 Import numeric data from a text file as a matrix.
%   ATL4FTW600TRAIN50PREDICTION = IMPORTFILE1(FILENAME) Reads data from
%   text file FILENAME for the default selection.
%
%   ATL4FTW600TRAIN50PREDICTION = IMPORTFILE1(FILENAME, STARTROW, ENDROW)
%   Reads data from rows STARTROW through ENDROW of text file FILENAME.
%
% Example:
%   ATL4FTw600train50prediction = importfile1('AT_L4_FT_w600_train_50_prediction.txt', 1, 50);
%
%    See also TEXTSCAN.

% Auto-generated by MATLAB on 2021/01/15 10:27:01

%% Initialize variables.
delimiter = '';
if nargin<=2
    startRow = 1;
    endRow = inf;
end

%% Format string for each line of text:
%   column1: double (%f)
% For more information, see the TEXTSCAN documentation.
formatSpec = '%f%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to format string.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, endRow(1)-startRow(1)+1, 'Delimiter', delimiter, 'HeaderLines', startRow(1)-1, 'ReturnOnError', false);
for block=2:length(startRow)
    frewind(fileID);
    dataArrayBlock = textscan(fileID, formatSpec, endRow(block)-startRow(block)+1, 'Delimiter', delimiter, 'HeaderLines', startRow(block)-1, 'ReturnOnError', false);
    dataArray{1} = [dataArray{1};dataArrayBlock{1}];
end

%% Close the text file.
fclose(fileID);

%% Post processing for unimportable data.
% No unimportable data rules were applied during the import, so no post
% processing code is included. To generate code which works for
% unimportable data, select unimportable cells in a file and regenerate the
% script.

%% Create output variable
predicted_value = [dataArray{1:end-1}];
