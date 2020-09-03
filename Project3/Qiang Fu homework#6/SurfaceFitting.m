function [Ic,Ir,It,Icc,Irc,Itc,Icr,Irr,Itr,Ict,Irt,Itt,flag] =SurfaceFitting(c,r,t,windowsize_c,windowsize_r,windowsize_t,seq) 
    if ~exist('D','var')
        D = ConstructD(windowsize_c,windowsize_r,windowsize_t);
    end
    J = [];
    for k = -(windowsize_t-1)/2:(windowsize_t-1)/2         
        for i = -(windowsize_c-1)/2:(windowsize_c-1)/2
            for j = -(windowsize_r-1)/2:(windowsize_r-1)/2
            J = [J;double(seq(r+j,c+i,t+k))];
            end
        end
    end
    %a = D\J;
    a = (D'*D)^-1*D'*J;
    error = norm(D*a-J);
    
    Ic = a(2);
    Ir = a(3);
    It = a(4);
    Icc = 2*a(5);
    Irc = a(6);
    Itc = a(10);
    Icr = a(6);
    Irr = 2*a(7);
    Itr = a(8);
    Ict = a(10);
    Irt = a(8);
    Itt = 2*a(9);
    if error<100
    flag = 1;
    else
        flag = 0;
    end
end

