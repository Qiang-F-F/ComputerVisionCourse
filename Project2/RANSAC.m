%using_left = 0;
if using_left
    pts_2D = left_2D;
else
    pts_2D = right_2D;
end
max = 0;%max number of inliers
good = [];%Numbers of good 3D points
N = 8;
p = 0.9;
s = ceil(log(1-p)/log(1-(1-0.18)^N));%Calculate steps of the iteration
for k = 1:s
    flag = 0;
    A = []; 
    n = unidrnd(48,N,1);
    for i = 1:N
        point_3D = pts_3D(n(i),2:4);
        point_2D = pts_2D(n(i),2:3);
        A = [A;point_3D,1,0,0,0,0,-point_2D(1).*[point_3D,1];0,0,0,0,point_3D,1,-point_2D(2).*[point_3D,1]];
%{
        if Bad_3D(n(i),:) == Good_3D(n(i),:)%For debug
            flag = flag+1;
            if flag == N
                disp("OK");
            end
        end
%}        
    end
    if rank(A) >= 11 %To make sure the 3D points we use are not coplanar
        [W,R,t]=Solve_WRt(A);
        count = 0;%Number of inliers respect to the current P matrix
        num =[];%To store the numbers of inlier 3D points respect to the current P matrix
        for j =1:48
            temp = W*[R,t]*[pts_3D(j,2:4)';1];
            temp = temp./temp(3);
            error = norm(pts_2D(j,2:3)'-[temp(1);temp(2)],2);
            if error <4%If the error is smaller than 4 pixels, we classify it as an inlier
                count = count +1;
                num=[num;j];
            end
        end
        if count >= max%Renew the max number of inliers, if the inlier number respect to the current P matrix is larger
            max = count;
            good = num;%Renew the numbers of the inlier 3D points
            %nn= n;%For debug
        end
    else
        k = k-1; %If rank(A)<11, don't count for this loop
    end
end
%{
%For debug, to see if there are bad points in the N points we use to
calculate the P matrix
for i =1:N 
    if Bad_3D(nn(i),:) ~= Good_3D(nn(i),:)
        disp("Bad Point");
    end
end
%}
%flag = 0;%For debug
for i = 1:max
    %{
    %For debug, count the number of bad points in the points set we use to calculate the final P matrix
    if Bad_3D(good(i),:) == Good_3D(good(i),:)
        flag = flag +1;
    end
    %}
    point_3D = pts_3D(good(i),2:4);
    point_2D = pts_2D(good(i),2:3);
    A = [A;point_3D,1,0,0,0,0,-point_2D(1).*[point_3D,1];0,0,0,0,point_3D,1,-point_2D(2).*[point_3D,1]];
end
%{
%For debug
if flag ==max
    disp("All good")
else
    disp("Not all good")
end
%}
%Calculate the W,R,t using all the good points
A=[];
for i = 1:max
    point_3D = pts_3D(good(i),2:4);
    point_2D = pts_2D(good(i),2:3);
    A = [A;point_3D,1,0,0,0,0,-point_2D(1).*[point_3D,1];0,0,0,0,point_3D,1,-point_2D(2).*[point_3D,1]];
end

if rank(A) >= 11
    [W,R,t,P] = Solve_WRt(A);
    test = [R,t]*[pts_3D(1,2:4)';1];
    if test(3)<0
    R = -R;
    t = -t;
    end
end
if using_left
    Wl = W;
    Rl = R;
    tl = t;
else
    Wr = W;
    Rr = R;
    tr = t;
end
temp = ones(1,48);
re = W*[R,t]*[pts_3D(:,2:4)';temp];
x = re(1,:)./re(3,:);
y = re(2,:)./re(3,:);
figure(1)
if using_left
    im = imread('./project2_data/calibration/left_pattern.jpg');
else
    im = imread('./project2_data/calibration/right_pattern.jpg');
end
imshow(im);
hold on;
plot(x,y,'o','color','r');