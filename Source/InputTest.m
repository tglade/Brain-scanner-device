%Modified from tuto1_signal_filer_Process.m
%
%Currently attempting to handle two inputs, and map the corresponding chunk
%to a new matrix, which contains the chunk and the appropriate keypress.
%Plan is to use this matrix to train a neural net in the uninit script.
%
%Modified by: Adam
%Last Modified: 15/4/16

function box_out = InputTest(box_in)
    
    %variables for keybindings
    persistent w;
    persistent s;
    
    %input and target test matrices
    persistent xArray;
    persistent tArray;
    
    %loop variable for matrix append
    persistent j;
    
    %initialize persitent vars if not set
    if isempty(j)
        j = 1;
    end
    if isempty(xArray)
        xArray = zeros(14, 32, 1);
    end
    if isempty(tArray)
        tArray = zeros(2, 1);
    end
    
    for i = 1: OV_getNbPendingInputChunk(box_in,2)
		
		% Pop the first stimulation chunk (2 denotes stimulations)
		[box_in, start_time, end_time, stim_set] = OV_popInputBuffer(box_in,2);
		
        %stim_set is a 3x1 matrix, where the first value is the value of
        %the label sent by the simulation. If there is at least one
        %stimulation in the set, run the keyboar handler.
        if(numel(stim_set) >= 3)
            %33205 is the value of stimulation label 01. 
            if stim_set(1) == 33025
                w = 1;
                %switch a trigger so that the chunk of data is handled
                %later
                box_in.user_data.trigger_state = ~box_in.user_data.trigger_state;
            %33026 is the value of stimulation label 02
            elseif stim_set(1) == 33026
                s = 1;
                box_in.user_data.trigger_state = ~box_in.user_data.trigger_state;
            end
        end
    end

    %code for handling chunks of data. Each chunk should only be handled if
    %the trigger is true (stimulation has been processed).
    for i = 1: OV_getNbPendingInputChunk(box_in,1)
        [box_in, start_time, end_time, matrix_data] = OV_popInputBuffer(box_in,1);   
        
        box_in.outputs{1}.header = box_in.inputs{1}.header;
        
        %if trigger is true, push data chunk to new data matrix (x). Push
        %associated stimulation chunk to output matrix (t).
        if (box_in.user_data.trigger_state)
            box_in.user_data.trigger_state = ~box_in.user_data.trigger_state;
            if (w == 1)
                w = 0;
                xArray(:, :, j) = matrix_data;
                tArray(:, j) = [1 0];
                j = j + 1;
            elseif (s == 1)
                s = 0;
                xArray(:, :, j) = matrix_data;
                tArray(:, j) = [0 1];
                j = j + 1;                
            end
        end
        
        %save variables to use in uninit file to train net
        save('train.mat', 'xArray', 'tArray', '-v7.3');
        
        
    end
    
    box_out = box_in;

end

