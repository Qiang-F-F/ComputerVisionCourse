Good_3D = load("./3Dpointnew.txt");
Bad_3D = load("./bad_3dpts.txt");
Pts_2D = load("./Left_2Dpoints.txt");

w = [100 0 50;0 100 50;0 0 1];
R =[2^2/2 0 2^2/2;2^2/2 0 -2^2/2;0 1 0];
t = [1;2;3];
P2 =[];
P3 = unidrnd(10,20,3);
N_v = [3^0.5/3;3^0.5/3;3^0.5/3];
P0 = [1;1;1];
p = [];
P = [];
for i =1:20
    temp = (w*[R,t]*[P0+(i-1)*N_v;1]);
    p = [p;(temp(1:2,1)./temp(3))'];
    P = [P;(P0+(i-1)*N_v)'];
end
n_v = (p(2,:)-p(1,:))/norm(p(2,:)-p(1,:),2);
a = n_v(2);
b = -n_v(1);
c = n_v(1)*p(1,2)-n_v(2)*p(1,1);
syms x y;
for i = 1:20
plot(p(i,1),p(i,2),'.');
if i == 1
hold;
end
end
fimplicit(a*x+b*y+c);
A=[];
    point_3D = P(1,:);
    point_2D = p(1,:);
    A = [A;point_3D,1,0,0,0,0,-point_2D(1).*[point_3D,1];0,0,0,0,point_3D,1,-point_2D(2).*[point_3D,1];a*P(2,:),1,b*P(2,:),1,c*P(2,:),1;a*P(3,:),1,b*P(3,:),1,c*P(3,:),1;a*P(4,:),1,b*P(4,:),1,c*P(4,:),1;a*P(5,:),1,b*P(5,:),1,c*P(5,:),1];

r = rank(A);

