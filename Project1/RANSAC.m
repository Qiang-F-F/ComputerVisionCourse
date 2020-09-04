Good_3D = load("./3Dpointnew.txt");
Bad_3D = load("./bad_3dpts.txt");
Pts_2D = load("./Left_2Dpoints.txt");

max = 0;%max number of inliers
good = [];%Numbers of good 3D points
N = 8;
p = 0.9;
s = ceil(log(1-p)/log(1-(1-0.18)^N));%Calculate steps of the iteration
for k = 1:s
    flag = 0;
    A = [];
    n = unidrnd(72,N,1);
    for i = 1:N
        point_3D = Bad_3D(n(i),:);
        point_2D = Pts_2D(n(i),:);
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
        for j =1:72
            temp = W*[R,t]*[Bad_3D(j,:)';1];
            temp = temp./temp(3);
            error = norm(Pts_2D(j,:)'-[temp(1);temp(2)],2);
            if error <4%If the error is smaller than 4 pixels, we classify it as an inlier
                count = count +1;
                num=[num;j];
            end
        end
        if count >= max;%Renew the max number of inliers, if the inlier number respect to the current P matrix is larger
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
    point_3D = Bad_3D(good(i),:);
    point_2D = Pts_2D(good(i),:);
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
    point_3D = Bad_3D(good(i),:);
    point_2D = Pts_2D(good(i),:);
    A = [A;point_3D,1,0,0,0,0,-point_2D(1).*[point_3D,1];0,0,0,0,point_3D,1,-point_2D(2).*[point_3D,1]];
end

if rank(A) >= 11
    [W,R,t,P] = Solve_WRt(A);
    test = [R,t]*[Good_3D(1,:)';1];
    if test(3)<0
    R = -R;
    t = -t;
    end
end
%Verify if the answer is correct
plot(Pts_2D(:,1),Pts_2D(:,2),'o','color','b');%Plot the given 2D points
hold;
%Plot the 2D projected from the good 3D points
e = 0;
for j =1:72
    temp = W*[R,t]*[Good_3D(j,:)';1];
    temp = temp./temp(3);
    temp_2 = [Pts_2D(j,1)-temp(1),Pts_2D(j,2)-temp(2)];
    e= e+norm(temp_2,2);
    plot(temp(1),temp(2),'*','color','r');
end
inliers_3D = [];
inliers_2D = [];
reprojected_2D = [];
V_hat = [];
V = [];
for i = 1:max
    inliers_3D = [inliers_3D;Bad_3D(good(i),:)];
    inliers_2D = [inliers_2D;Pts_2D(good(i),:)];
    temp = [(Bad_3D(good(i),:)*P(1:3)+P(4))/(Bad_3D(good(i),:)*P(9:11)+P(12)),(Bad_3D(good(i),:)*P(5:7)+P(8))/(Bad_3D(good(i),:)*P(9:11)+P(12))];
    reprojected_2D = [reprojected_2D;temp];
    V_hat = [V_hat;temp(1);temp(2)];
    V = [V;inliers_2D(1);inliers_2D(2)];
end