lambda_1 = 5;
lambda_2 = 5;

for i = 1 : max
    e2 = norm(reprojected_2D(i) - inliers_2D(i),2)^2;
end
e2 = e2 + lambda_1*(norm(P(9:11),2)^2-1)+lambda_2*(dot(cross(P(1:3),P(9:11)),cross(P(5:7),P(9:11))));
I  = eye(3);
%I X P3
IxP3 = [cross(I(:,1),P(9:11)),cross(I(:,2),P(9:11)),cross(I(:,3),P(9:11))];
IxP2 = [cross(I(:,1),P(5:7)),cross(I(:,2),P(5:7)),cross(I(:,3),P(5:7))];
IxP1 = [cross(I(:,1),P(1:3)),cross(I(:,2),P(1:3)),cross(I(:,3),P(1:3))];
de2dP_3 = lambda_2*[IxP3;zeros(5,3);IxP1;zeros(1,3)]*cross(P(5:7),P(9:11))+[zeros(4,3);IxP3;zeros(1,3);IxP2;zeros(1,3)]*cross(P(1:3),P(9:11));
de2dP_2 = 2*lambda_2*[zeros(8,3);IxP3;zeros(1,3)]*P(9:11);
dV_hatdP = [];
for i = 1:12
    temp_P = P;
    temp_d = [];
    temp_P(i) = temp_P(i)*1.001;
    for j = 1:max
        d = ([(Bad_3D(good(i),:)*temp_P(1:3)+temp_P(4))/(Bad_3D(good(i),:)*temp_P(9:11)+temp_P(12)),(Bad_3D(good(i),:)*temp_P(5:7)+temp_P(8))/(Bad_3D(good(i),:)*temp_P(9:11)+temp_P(12))]-[(Bad_3D(good(i),:)*P(1:3)+P(4))/(Bad_3D(good(i),:)*P(9:11)+P(12)),(Bad_3D(good(i),:)*P(5:7)+P(8))/(Bad_3D(good(i),:)*P(9:11)+P(12))])/0.001*P(i); 
        temp_d = [temp_d,d];
    end
    dV_hatdP = [dV_hatdP;temp_d];
end
de2dP_1 = 2*dV_hatdP*(V_hat-V);

de2dP = de2dP_1+de2dP_2+de2dP_3;