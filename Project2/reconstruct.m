left_face = load('./project2_data/faceimage/pts_left.txt');
right_face = load('./project2_data/faceimage/pts_right.txt');
Pl = Wl*[Rl,tl];
Pr = Wr*[Rr,tr];
Points_3D =[];
for i = 1:30
cl = left_face(i,2);
rl = left_face(i,3);
cr = right_face(i,2);
rr = right_face(i,3);
A = [cl*Pl(3,1:3)-Pl(1,1:3);rl*Pl(3,1:3)-Pl(2,1:3);cr*Pr(3,1:3)-Pr(1,1:3);rr*Pr(3,1:3)-Pr(2,1:3);];
b = [Pl(1,4)-cl*Pl(3,4);Pl(2,4)-rl*Pl(3,4);Pr(1,4)-cr*Pr(3,4);Pr(2,4)-rr*Pr(3,4)];
Points_3D = [Points_3D,A\b];%the result of A\b is the least square solution of Ax=b
end
right_eye = norm(Points_3D(:,11)-Points_3D(:,14),2);
left_eye = norm(Points_3D(:,17)-Points_3D(:,20),2);
mouse = norm(Points_3D(:,23)-Points_3D(:,27),2);
plot3(Points_3D(1,11:16),Points_3D(2,11:16),Points_3D(3,11:16),'-');
hold on;
plot3([Points_3D(1,11),Points_3D(1,16)],[Points_3D(2,11),Points_3D(2,16)],[Points_3D(3,11),Points_3D(3,16)],'-');hold on;
plot3(Points_3D(1,17:22),Points_3D(2,17:22),Points_3D(3,17:22),'-');
hold on;
plot3([Points_3D(1,17),Points_3D(1,22)],[Points_3D(2,17),Points_3D(2,22)],[Points_3D(3,17),Points_3D(3,22)],'-');hold on;
plot3(Points_3D(1,1:3),Points_3D(2,1:3),Points_3D(3,1:3),'-');
plot3(Points_3D(1,4:6),Points_3D(2,4:6),Points_3D(3,4:6),'-');
i = 7,j=8;
plot3([Points_3D(1,i),Points_3D(1,j)],[Points_3D(2,i),Points_3D(2,j)],[Points_3D(3,i),Points_3D(3,j)],'-');hold on;
i = 8,j=9;
plot3([Points_3D(1,i),Points_3D(1,j)],[Points_3D(2,i),Points_3D(2,j)],[Points_3D(3,i),Points_3D(3,j)],'-');hold on;
i = 8,j=10;
plot3([Points_3D(1,i),Points_3D(1,j)],[Points_3D(2,i),Points_3D(2,j)],[Points_3D(3,i),Points_3D(3,j)],'-');hold on;
plot3(Points_3D(1,23:30),Points_3D(2,23:30),Points_3D(3,23:30),'-');
i = 23,j=30;
plot3([Points_3D(1,i),Points_3D(1,j)],[Points_3D(2,i),Points_3D(2,j)],[Points_3D(3,i),Points_3D(3,j)],'-');hold on;
plot3(Points_3D(1,:),Points_3D(2,:),Points_3D(3,:),'*');
%plot3(pts_3D(:,2),pts_3D(:,3),pts_3D(:,4),'o');