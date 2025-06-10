def LIBFFM_generator(data):
    #input = txt file
    
    import numpy as np
    import pandas as pd

    training_data = pd.read_csv(data+".txt",sep=' ',header=None)
    training_data = training_data.values.astype(np.float32)
    print(training_data)

    num_of_feature = len(training_data[0])-1
    num_of_thickness_bit = 6
    num_of_material_field = int((num_of_feature-num_of_thickness_bit)/2)

    thickness_field = np.zeros(num_of_thickness_bit)
    numbers = np.repeat(np.arange(1, num_of_material_field+1), 2)

    output_file = data+"_LIBFFM.txt"
    print(output_file)
    with open(output_file, 'w') as f_out:
            for row in training_data:
                target_variable = row[0]
                features = []
    
                # Specify fields
                field_mapping = np.concatenate((thickness_field,numbers))
                for i, (feature_value, field) in enumerate(zip(row[1:], field_mapping), start=0):
                    features.append((field, i, feature_value))
    
                line = f'{target_variable} ' + ' '.join([f'{int(field)}:{feature}:{int(value)}' for (field, feature, value) in features]) + '\n'
                f_out.write(line)