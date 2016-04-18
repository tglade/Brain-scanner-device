%Init function for classifier. Only important part is that the trigger_state
%is initialized to false.
%
%Modified by: Adam
%Last Modified: 17/4/16
function box_out = ADOutput_Initialize(box_in)
    disp('Initialize function has been called');
    
    box_in.user_data.trigger_state = false;
    box_out = box_in;
    
end