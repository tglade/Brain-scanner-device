%Modified from tuto1_signal_filer_Process.m
%
%Currently attempting to handle two inputs, and map the corresponding chunk
%to a new matrix, which contains the chunk and the appropriate keypress.
%Plan is to use this matrix to train a neural net in the uninit script.
%
%Modified by: Adam
%Last Modified: 12/4/16

function box_out = InputTest(box_in)

    import java.awt.AWTException;
    import java.awt.Robot;
    import java.awt.event.KeyEvent;
    import java.util.concurrent.TimeUnit;
    
    robot=Robot;
    w = 0;
    s = 0;
    
    for i = 1: OV_getNbPendingInputChunk(box_in,2)
		
		% Pop the first stimulation chunk (2 denotes stimulations)
		[box_in, start_time, end_time, stim_set] = OV_popInputBuffer(box_in,2);
		
		% the stimulation set is a 3xN matrix.
		% The openvibe stimulation stream sends even empty stimulation set
		% so the following boxes know there is no stimulation to expect in
		% the latest time range. These empty chunk are also in the matlab buffer.
		if(numel(stim_set) >= 3) % at least one stim in the set.
            if stim_set(1) == 33025
                disp(stim_set(1));
                w = 1;
                box_in.user_data.trigger_state = ~box_in.user_data.trigger_state;
            end
            
            if stim_set(1) == 33026
                s = 1;
                box_in.user_data.trigger_state = ~box_in.user_data.trigger_state;
            end
        end
	end

    for i = 1: OV_getNbPendingInputChunk(box_in,1)
        [box_in, start_time, end_time, matrix_data] = OV_popInputBuffer(box_in,1);   
        
        box_in.outputs{1}.header = box_in.inputs{1}.header;
        
        if (box_in.user_data.trigger_state)
            box_in.user_data.trigger_state = ~box_in.user_data.trigger_state;
            disp(box_in.user_data.trigger_state);
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

