function [state,Sigma] = kalman_filter(I1,I2,s,A,H,Q,R,sigma)
    s_e = A*s;
    sigma_e = A*sigma*A'+Q;
    z = feature_detetor(I1,I2,s_e,s,sigma_e);
    k = sigma_e*H'*(H*sigma_e*H'+R)^-1;
    state = round(s_e+k*(z'-H*s_e));
    Sigma = (eye(4,4)-k*H)*sigma_e;
end