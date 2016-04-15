function box_out = one_eye_trainer_Initialize(box_in)
    disp('Initialize function has been called');
    
    box_in.user_data.trigger_state = false;
    box_out = box_in;
end