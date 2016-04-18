%Scripting to handle classification of data stream after neural net has
%been trained. Also handles keyboard output.
%
%Modified by: Adam
%Last Modified: 17/4/16

function box_out = ADOutput(box_in)

    %imports for keyboard output handling
    import java.awt.AWTException;
    import java.awt.Robot;
    import java.awt.event.KeyEvent;
    import java.util.concurrent.TimeUnit;
    
    robot=Robot;

    %code for handling chunks of data. Each chunk should only be handled if
    %the trigger is true (stimulation has been processed).
    for i = 1: OV_getNbPendingInputChunk(box_in,1)
        [box_in, ~, ~, matrix_data] = OV_popInputBuffer(box_in,1);   
        
        box_in.outputs{1}.header = box_in.inputs{1}.header;
        
        %load net
        load('net.mat', 'net', 'tr');
        
        %get max value of input data, and get associated column       
        [~,I] = max(matrix_data(:));
        [~,n] = ind2sub(size(matrix_data), I);
        data = matrix_data(:,n);
        
        %run net on chunk
        out = net(data);
        
        %display output. 
        disp(out);
        
        if (out(1) > .6)
            robot.keyRelease(KeyEvent.VK_D);
            robot.keyPress(KeyEvent.VK_A);
        elseif (out(2) > .6)
            robot.keyRelease(KeyEvent.VK_A);
            robot.keyPress(KeyEvent.VK_D);
        else
            robot.keyRelease(KeyEvent.VK_A);
            robot.keyRelease(KeyEvent.VK_D);
        end
        
    end
    
    box_out = box_in;

end

