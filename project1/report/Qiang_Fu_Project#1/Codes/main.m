Good_3D = load("./3Dpointnew.txt");
Bad_3D = load("./bad_3dpts.txt");
Pts_2D = load("./Left_2Dpoints.txt");
r=0;
while 1
    A=[];
    for i = 1:72
        point_3D = Bad_3D(i,:);
        point_2D = Pts_2D(i,:);
        A = [A;point_3D,1,0,0,0,0,-point_2D(1).*[point_3D,1];0,0,0,0,point_3D,1,-point_2D(2).*[point_3D,1]];
    end

    if rank(A) >= 11
        [W,R,t] = Solve_WRt(A);
        test = [R,t]*[Good_3D(1,:)';1];
        if test(3)<0
        end
        break;
    else
        continue;
    end
end

plot(Pts_2D(:,1),Pts_2D(:,2),'o','color','b');
hold;
e = 0;
for j =1:72
    temp = W*[R,t]*[Good_3D(j,:)';1];
    temp = temp./temp(3);
    temp_2 = [Pts_2D(j,1)-temp(1),Pts_2D(j,2)-temp(2)];
    e= e+norm(temp_2,2);
    plot(temp(1),temp(2),'*','color','r');
end
W
R
t