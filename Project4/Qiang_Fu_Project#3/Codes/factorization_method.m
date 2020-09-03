function [R,S] = factorization_method(W)
    [U,D,V] = svd(W);
    D_temp = D(1:3,1:3);
    R_temp = U(:,1:3)*D_temp^0.5;
    S_temp = (V(:,1:3)*D_temp^0.5)';
    %solve QQ'
    A = [];
    b = [];
    for i = 1:2:length(R_temp(:,1))
        %{
        A = [A;
            R_temp(i,1)*R_temp(i,:),R_temp(i,2)*R_temp(i,:),R_temp(i,2)*R_temp(i,:);
            R_temp(i+1,1)*R_temp(i+1,:),R_temp(i+1,2)*R_temp(i+1,:),R_temp(i+1,2)*R_temp(i+1,:);
            R_temp(i+1,1)*R_temp(i,:),R_temp(i+1,2)*R_temp(i,:),R_temp(i+1,2)*R_temp(i,:)]; 
        %}
        A = [A;
             R_temp(i,1)*R_temp(i,1),2*R_temp(i,2)*R_temp(i,1),2*R_temp(i,3)*R_temp(i,1),R_temp(i,2)^2,2*R_temp(i,2)*R_temp(i,3),R_temp(i,3)^2;
             R_temp(i+1,1)*R_temp(i+1,1),2*R_temp(i+1,2)*R_temp(i+1,1),2*R_temp(i+1,3)*R_temp(i+1,1),R_temp(i+1,2)^2,2*R_temp(i+1,2)*R_temp(i+1,3),R_temp(i+1,3)^2;
             R_temp(i,1)*R_temp(i+1,1),R_temp(i,2)*R_temp(i+1,1)+R_temp(i,1)*R_temp(i+1,2),R_temp(i,3)*R_temp(i+1,1)+R_temp(i,1)*R_temp(i+1,3),R_temp(i,2)*R_temp(i+1,2),R_temp(i,3)*R_temp(i+1,2)+R_temp(i,2)*R_temp(i+1,3),R_temp(i,3)*R_temp(i+1,3)];
       b = [b;1;1;0];
    end
    QQT = A\b;
    QQT = [QQT(1),QQT(2),QQT(3);
           QQT(2),QQT(4),QQT(5);
           QQT(3),QQT(5),QQT(6)];
    %solve Q
    [Ua,Da,Va] = svd(QQT);
    Q = Ua*Da^0.5;
    R = R_temp*Q;
    S = Q^-1*S_temp;
end