%Unit function for trainer. All neural net training is done here to prevent
%slow-down, and to ensure complete data from the user. The trained neural
%net is then save to 'net.mat'.
%
%Modified by: Adam
%Last Modified: 16/4/16
function box_out = InputTest_Uninitialize(box_in)

	disp('Training neural net. Please do not close window.')
    
    %load up arrays from the trainer.
    load('train.mat', 'xArray', 'tArray');
    
    %show size to make sure we have the right number of entries (temporary
    %display, will remove later, as users don't need/care about this)
    disp(size(xArray));
    disp(size(tArray));
    
    %train up the neural net
    net = patternnet(10);
    [net,tr] = train(net,xArray,tArray);
    nntraintool;
    plotperform(tr);
    
    %save the net
    save('net.mat', 'net', 'tr', '-v7.3');
    
    box_out = box_in;
end