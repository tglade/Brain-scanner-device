function box_out = InputTest_Uninitialize(box_in)
    import java.awt.AWTException;
    import java.awt.Robot;
    import java.awt.event.KeyEvent;

	disp('Matlab uninitialize function has been called.')
    robot = Robot;
    
    %robot.KeyRelease(KeyEvent.VK_RIGHT);
    %robot.KeyRelease(KeyEvent.VK_LEFT);

	box_out = box_in;
end