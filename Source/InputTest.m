
function box_out = InputTest(box_in)

    import java.awt.AWTException;
    import java.awt.Robot;
    import java.awt.event.KeyEvent;
    import java.util.concurrent.TimeUnit;
    
    robot=Robot;

    for i = 1: OV_getNbPendingInputChunk(box_in,1)
        
        [box_in, start_time, end_time, matrix_data] = OV_popInputBuffer(box_in,1);
        
        L = box_in.inputs{1}.header.nb_samples_per_buffer;
        sum = 0;
        
        for j = 1:L
           
            sum = sum + matrix_data(j);
            
        end
        
        average = sum / L;
        
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
        
        TimeUnit.SECONDS.sleep(2);
    
    end
    
    box_out = box_in;

end

