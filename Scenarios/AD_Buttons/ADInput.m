%Trainer handling for neural net. All neural net handling is done in the
%uninit file. This file is only for gathering the data. The data is then
%saved to the 'train.mat' file.
%
%Modified by: Adam
%Last Modified: 16/4/16

function box_out = ADInput(box_in)
    
    %variables for keybindings
    persistent a;
    persistent d;
    
    %input and target test matrices
    persistent xArray;
    persistent tArray;
    
    %loop variable for matrix append
    persistent j;
    persistent k;
    
    %initialize persitent vars if not set
    if isempty(j)
        j = 1;
    end
    if isempty(k)
        k = 1;
    end
    if isempty(xArray)
        xArray = zeros(14, 1);
    end
    if isempty(tArray)
        tArray = zeros(3, 1);
    end
    
    for i = 1: OV_getNbPendingInputChunk(box_in,2)
		
		% Pop the first stimulation chunk (2 denotes stimulations)
		[box_in, ~, ~, stim_set] = OV_popInputBuffer(box_in,2);
		
        %stim_set is a 3x1 matrix, where the first value is the value of
        %the label sent by the simulation. If there is at least one
        %stimulation in the set, run the keyboar handler.
        if(numel(stim_set) >= 3)
            disp(stim_set);
            %33205 is the value of stimulation label 01. 
            if stim_set(1) == 33025
                a = 1;
                %switch a trigger so that the chunk of data is handled
                %later
                box_in.user_data.trigger_state = ~box_in.user_data.trigger_state;
            %33026 is the value of stimulation label 02
            elseif stim_set(1) == 33026
                d = 1;
                box_in.user_data.trigger_state = ~box_in.user_data.trigger_state;
            end
        end
    end

    %code for handling chunks of data. Each chunk should only be handled if
    %the trigger is true (stimulation has been processed).
    for i = 1: OV_getNbPendingInputChunk(box_in,1)
        [box_in, ~, ~, matrix_data] = OV_popInputBuffer(box_in,1);   
        
        box_in.outputs{1}.header = box_in.inputs{1}.header;
        
        %if trigger is true, push data chunk to new data matrix (x). Push
        %associated stimulation chunk to output matrix (t).
        if (box_in.user_data.trigger_state)
            box_in.user_data.trigger_state = ~box_in.user_data.trigger_state;
            if (a == 1)
                a = 0;
                [~,I] = max(matrix_data(:));
                [~,n] = ind2sub(size(matrix_data), I);
                xArray(:,j) = matrix_data(:,n);
                tArray(:, j) = [1 0 0];
                j = j + 1;
                k = 1;
            elseif (d == 1)
                d = 0;
                %get max value in a chunk, and get the column
                [~,I] = max(matrix_data(:));
                [~,n] = ind2sub(size(matrix_data), I);
                xArray(:,j) = matrix_data(:,n);
                tArray(:, j) = [0 1 0];
                j = j + 1;  
                k = 1;
            end
        else
            if (k == 10)
                [~,I] = max(matrix_data(:));
                [~,n] = ind2sub(size(matrix_data), I);
                xArray(:,j) = matrix_data(:,n);
                tArray(:,j) = [0 0 1];
                k = 1;
                j = j + 1;
            else
                k = k + 1;
            end 
        end
        
        %save variables to use in uninit file to train net
        save('train.mat', 'xArray', 'tArray', '-v7.3');
        
        
        
    end
    
    box_out = box_in;

end

