%Modified (heavily) from tuto1_signal_filer_Process.m
%
%Scripting to handle classification of data stream after neural net has
%been trained.
%
%Modified by: Adam
%Last Modified: 15/4/16

function box_out = one_eye_color_test(box_in)
    
    persistent rImage;
    persistent rSwitch;
    if isempty(rSwitch)
        rSwitch = 0;
    end

    %code for handling chunks of data. Each chunk should only be handled if
    %the trigger is true (stimulation has been processed).
    for i = 1: OV_getNbPendingInputChunk(box_in,1)
        [box_in, start_time, end_time, matrix_data] = OV_popInputBuffer(box_in,1);   
        
        box_in.outputs{1}.header = box_in.inputs{1}.header;
        
        %load net
        load('net.mat', 'net', 'tr');
        
        %load the testing image (this will be removed or commented out
        %later)
        rImage = imread('r_square.png');
        gImage = imread('g_square.png');
        imshow(rImage);
        
        %get max value of input data, and get associated column       
        [~,I] = max(matrix_data(:));
        [~,n] = ind2sub(size(matrix_data), I);
        data = matrix_data(:,n);
        
        %run net on chunk
        out = net(data);
        
        %test on one eye blink. Will be removed or changed later. 
        if (out(1) > .6)
            %flip colors
            if (rSwitch == 0)
                imshow(gImage);
                rSwitch = 1;
            elseif (rSwitch == 1)
                imshow(rImage);
                rSwitch = 0;
            end
        end
        
    end
    
    box_out = box_in;

end

