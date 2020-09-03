function [W,R,t,P] = Solve_WRt(A)
r = rank(A);
if r >= 11 
%Reconstract A matrix to make sure rank(A)=11
[U,S,V] = svd(A);
S(12,12) = 0;
A = U*S*V';
%Apply SVD to A matrix
[U,S,V] = svd(A);
P = V(:,12);
%Add constrains to P, that norm(r3)=1
P = P./norm(P(9:11,1),2);
%Reconstract W,R,t
r3 = P(9:11,1);
tz = P(12);
c0 = P(1:3,1)'*P(9:11,1);
r0 = P(5:7,1)'*P(9:11,1);
sxf = norm(cross(P(1:3,1),P(9:11,1)),2);
syf = norm(cross(P(5:7,1),P(9:11,1)),2);
tx = (P(4)-c0*tz)/sxf;
ty = (P(8)-r0*tz)/syf;
r1 = (P(1:3,1)-c0*r3)/sxf;
r2 = (P(5:7,1)-r0*r3)/syf;

R = [r1';r2';r3'];
t = [tx;ty;tz];

W = [sxf,0,c0;0,syf,r0;0,0,1]; 
else
    W = 0;
    R = 0;
    t = 0;
    disp("Error: rank(A) < 11")
end

