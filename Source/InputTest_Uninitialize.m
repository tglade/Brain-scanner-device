function box_out = InputTest_Uninitialize(box_in)

	disp('Training neural net. Please do not close window.')
    
    %load up arrays from the trainer.
    load('train.mat', 'xArray', 'tArray');
    
    %show size to make sure we have the right number of entries (temporary
    %display, will remove later, as users don't need/care about this)
    disp(size(xArray));
    disp(size(tArray));
    
    %try reshaping x to train. May work, may not.
    newX = reshape(xArray(:,:,:),[],14);
    
    %train up the neural net
    net = patternnet(10);
    [net,tr] = train(net,newX,tArray);
    nntraintool;
    plotperform(tr);
    
    %save the net
    save('net.mat', 'net', 'tr', '-v7.3');
    
    box_out = box_in;
end