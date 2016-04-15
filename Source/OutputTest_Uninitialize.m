%Uninit function for classifier. Should assure that all keys are released
%upon closing the program (should any still be pressed). May throw an error
%in current state that "xyz key cannot be relased", or something to that
%effect. This is because we need to check to see which keys are actually
%pressed and then release only those, rather than all keys possible.
%
%Modified by: Adam
%Last Modified: 16/4/16
function box_out = OutputTest_Uninitialize(box_in)
	disp('Unitializing...')
    
    %imports for keyboard output handling
    import java.awt.AWTException;
    import java.awt.Robot;
    import java.awt.event.KeyEvent;
    import java.util.concurrent.TimeUnit;
    
    robot=Robot;
    robot.keyRelease(KeyEvent.VK_RIGHT);
    robot.keyRelease(KeyEvent.VK_LEFT);
    
    box_out = box_in;
end