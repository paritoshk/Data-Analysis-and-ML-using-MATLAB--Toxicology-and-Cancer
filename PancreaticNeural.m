
[x,t] = pancreatic_dataset;
x = transpose(x);
whos x t
setdemorandstream(675287915)
net = patternnet(2);
view(net)
[net,tr] = train(net,x,t);
plotperform(tr)
testX = x(:,tr.testInd);
testT = t(:,tr.testInd);

testY = net(testX);
testClasses = testY > 0.5
plotconfusion(testT,testY)
[c,cm] = confusion(testT,testY);

fprintf('Percentage Correct Classification   : %f%%\n', 100*(1-c));
fprintf('Percentage Incorrect Classification : %f%%\n', 100*c);
plotroc(testT,testY)