%Modified from tuto1_signal_filer_Process.m
%
%Currently attempting to handle two inputs, and map the corresponding chunk
%to a new matrix, which contains the chunk and the appropriate keypress.
%Plan is to use this matrix to train a neural net in the uninit script.
%
%Modified by: Adam
%Last Modified: 13/4/16

function box_out = InputTest(box_in)

    %import java.awt.AWTException;
    %import java.awt.Robot;
    %import java.awt.event.KeyEvent;
    %import java.util.concurrent.TimeUnit;
    
    %robot=Robot;
    
    persistent w;
    persistent s;    
    
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
            end
            
            %33026 is the value of stimulation label 02
            if stim_set(1) == 33026
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
            disp(w);
            if (w == 1)
                disp(matrix_data);
            end
        end
        
        %{
        if (average > 0)
            robot.keyRelease(KeyEvent.VK_LEFT);
            robot.keyPress(KeyEvent.VK_RIGHT);
        elseif (average < 0)
            robot.keyRelease(KeyEvent.VK_RIGHT);
            robot.keyPress(KeyEvent.VK_LEFT);
        else
            robot.keyRelease(KeyEvent.VK_RIGHT);
            robot.keyRelease(KeyEvent.VK_LEFT);
        end
        %}
        
    end
    
    box_out = box_in;

end

