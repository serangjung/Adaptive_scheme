function trarcmlstudyBObat167 = importopttxt_mat_CYP(filename, startRow, endRow)
%IMPORTFILE �ؽ�Ʈ ������ ������ �����͸� ��ķ� �����ɴϴ�.
%   TRARCMLSTUDYBOBAT167 = IMPORTFILE(FILENAME) ����Ʈ ���� �׸��� �ؽ�Ʈ ����
%   FILENAME���� �����͸� �н��ϴ�.
%
%   TRARCMLSTUDYBOBAT167 = IMPORTFILE(FILENAME, STARTROW, ENDROW) �ؽ�Ʈ ����
%   FILENAME�� STARTROW �࿡�� ENDROW ����� �����͸� �н��ϴ�.
%
% Example:
%   trarcmlstudyBObat167 = importfile('tr_arc_ml_study_BO_bat1_67.txt', 1, 54);
%
%    TEXTSCAN�� �����Ͻʽÿ�.

% MATLAB���� ���� ��¥�� �ڵ� ������: 2022/02/22 19:14:35

%% ������ �ʱ�ȭ�մϴ�.
delimiter = ' ';
if nargin<=2
    startRow = 1;
    endRow = inf;
end

%% �� �ؽ�Ʈ ������ ����:
%   ��1: double (%f)
%	��2: double (%f)
%   ��3: double (%f)
%	��4: double (%f)
%   ��5: double (%f)
%	��6: double (%f)
% �ڼ��� ������ ���� �������� TEXTSCAN�� �����Ͻʽÿ�.
formatSpec = '%f%f%f%f%f%f%[^\n\r]';

%% �ؽ�Ʈ ������ ���ϴ�.
fileID = fopen(filename,'r');

%% ���Ŀ� ���� ������ ���� �н��ϴ�.
% �� ȣ���� �� �ڵ带 �����ϴ� �� ���Ǵ� ������ ����ü�� ������� �մϴ�. �ٸ� ���Ͽ� ���� ������ �߻��ϴ� ��� �������� ������
% �ڵ带 �ٽ� �����Ͻʽÿ�.
dataArray = textscan(fileID, formatSpec, endRow(1)-startRow(1)+1, 'Delimiter', delimiter, 'MultipleDelimsAsOne', true, 'TextType', 'string', 'HeaderLines', startRow(1)-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');
for block=2:length(startRow)
    frewind(fileID);
    dataArrayBlock = textscan(fileID, formatSpec, endRow(block)-startRow(block)+1, 'Delimiter', delimiter, 'MultipleDelimsAsOne', true, 'TextType', 'string', 'HeaderLines', startRow(block)-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');
    for col=1:length(dataArray)
        dataArray{col} = [dataArray{col};dataArrayBlock{col}];
    end
end

%% �ؽ�Ʈ ������ �ݽ��ϴ�.
fclose(fileID);

%% ������ �� ���� �����Ϳ� ���� ���� ó�� ���Դϴ�.
% �������� �������� ������ �� ���� �����Ϳ� ��Ģ�� ������� �ʾ����Ƿ� ���� ó�� �ڵ尡 ���Ե��� �ʾҽ��ϴ�. ������ �� ����
% �����Ϳ� ����� �ڵ带 �����Ϸ��� ���Ͽ��� ������ �� ���� ���� �����ϰ� ��ũ��Ʈ�� �ٽ� �����Ͻʽÿ�.

%% ��� ���� �����
trarcmlstudyBObat167 = [dataArray{1:end-1}];
