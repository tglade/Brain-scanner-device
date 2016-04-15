function box_out = one_eye_trainer_Uninitialize(box_in)

	disp('Training neural net. Please do not close window.')
    
    %load up arrays from the trainer.
    load('train.mat', 'xArray', 'tArray');
    
    %train up the neural net
    net = patternnet(10);
    [net,tr] = train(net,xArray,tArray);
    nntraintool;
    plotperform(tr);
    
    %save the net
    save('net.mat', 'net', 'tr', '-v7.3');
    
    box_out = box_in;
end