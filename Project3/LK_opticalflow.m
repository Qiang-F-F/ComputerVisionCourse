function [Optical_flow,flag] = LK_opticalflow(c,r,t,windowsize_c,windowsize_r,seq,threshold)
A = [];
b = [];
for i = c-(windowsize_c-1)/2:c+(windowsize_c-1)/2
    for j = r-(windowsize_r-1)/2:r+(windowsize_r-1)/2
        [Ic,Ir,It] = Numerical_method(i,j,t,seq);
        A = [A;Ic,Ir];
        b = [b;-It];
    end
end
Optical_flow = A\b;
flag = 1;
if norm(Optical_flow,2) < threshold(1) || norm(Optical_flow,2) > threshold(2)
    flag = 0;
    Optical_flow = [0;0];
end