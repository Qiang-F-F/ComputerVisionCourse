%{
read data
%}
I_seq = [];
for i = 10:39
    Path = sprintf('./proj4_img_seq/%d.pgm',i);
    I = imread(Path);
    I_seq(:,:,i-9) = I;
end
I_seq = Image_seq;
%{
set up state function
s0,A,H,Q,R,sigma_0
%}
%C1 = feature_detetor(I_seq(:,:,1),s,Q);

A = [1,0,1,0;0,1,0,1;0,0,1,0;0,0,0,1];
H = [1,0,0,0;0,1,0,0];
Q = 16*eye(4,4);
R = 9*eye(2,2);
temp = [100,0,0,0;
        0,100,0,0;
        0,0,25,0;
        0,0,0,25];

%C1 = [117,80;118,91;122,158;234,91;257,81;272,81;277,162;298,69;296,137];
C1 = P;
C2 = P;

s = [C1,C2-C1]';
sigma = [];
for i = 1:length(C1(:,1))
    sigma(:,:,i) = temp;
end

W = [];
SIGMA = [];
points = C1;
for i = 2:89
    
%{
implement Kalman filter to track the feature points
and update W matrix
%}
    for j = 1:length(C2(:,1))
        [state,Sigma] = kalman_filter(I_seq(:,:,i-1),I_seq(:,:,i),s(:,j),A,H,Q,R,sigma(:,:,j));
        s(:,j) = round(state);
        sigma(:,:,j) = Sigma;
    end
    SIGMA = [SIGMA;trace(sigma(:,:,1))];
    imshow(I_seq(:,:,i));   
    hold on;
    plot(s(1,:),s(2,:),'o');
    
    points(:,:,i) = s(1:2,:)';
    B = waitforbuttonpress;

%convert image coordinates to relative coordinates
Cr = convert_to_relative(s(1:2,:)',s(1:2,1)');

%update W matrix
temp = [];
for m = 1:length(s(1,:))
    temp = [temp,Cr(m,:)'];
end
W = [W;temp];
end
Cr1 = convert_to_relative(points(:,:,1),points(1,:,1));
W = [Cr1';W];
%{
implement the factorizing method to recovery the rotation and 3D structure
%}
[Rotation,Structure] = factorization_method(W);
Rotation_matrix = [];
for i =1:2:length(Rotation(:,1))
    Rotation(i,:) = Rotation(i,:)/norm(Rotation(i,:),2);
    Rotation(i+1,:) = Rotation(i+1,:)/norm(Rotation(i+1,:),2);
    Rotation_matrix(:,:,(i+1)/2) = [Rotation(i,:);Rotation(i+1,:);cross(Rotation(i,:),Rotation(i+1,:))];
end