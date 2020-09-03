for i = 1
C = detectFASTFeatures(I_seq(:,:,i));
imshow(I_seq(:,:,i));
hold on;
plot(selectStrongest(C, 20));
w = waitforbuttonpress;
end