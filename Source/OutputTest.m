%Modified (heavily) from tuto1_signal_filer_Process.m
%
%Scripting to handle classification of data stream after neural net has
%been trained.
%
%Modified by: Adam
%Last Modified: 15/4/16

function box_out = OutputTest(box_in)

    %import java.awt.AWTException;
    %import java.awt.Robot;
    %import java.awt.event.KeyEvent;
    %import java.util.concurrent.TimeUnit;
    
    %robot=Robot;

    %code for handling chunks of data. Each chunk should only be handled if
    %the trigger is true (stimulation has been processed).
    for i = 1: OV_getNbPendingInputChunk(box_in,1)
        [box_in, start_time, end_time, matrix_data] = OV_popInputBuffer(box_in,1);   
        
        box_in.outputs{1}.header = box_in.inputs{1}.header;
        
        %load net
        load('net.mat', 'net', 'tr');
        
        %reshape chunk to vector
        data = reshape(matrix_data(:,:),[],1);
        
        %run net on chunk
        out = net(data);
        
        %display output. Still some errors as far as classification.
        %Possibly due to improper usage of the reshape function. Also maybe
        %chunks are getting backed up in InputTest.m. Check that out later.
        disp(out);
        
        %documentation on keyoutput. Storing here for now. Will eventually
        %delete once above code is working.
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

