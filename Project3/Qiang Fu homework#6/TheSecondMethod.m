function [Optical_flow,flag] = TheSecondMethod(c,r,t,windowsize_c,windowsize_r,windowsize_t,seq,threshold)
    [Ic,Ir,It,Icc,Irc,Itc,Icr,Irr,Itr,Ict,Irt,Itt,flag] =SurfaceFitting(c,r,t,windowsize_c,windowsize_r,windowsize_t,seq);
    if flag == 1
        A = [Ic Ir;Icc Icr;Irc Irr;Itc Itr];
        b = -[It;Ict;Irt;Itt];
        if rank(A'*A)<2
            Optical_flow = [0;0];
            flag = 0;
        else
            %v = A\b;
            v = (A'*A)^-1*A'*b;
            Optical_flow = v(1:2);
            flag = 1;
            if norm(Optical_flow,2) < threshold(1) || norm(Optical_flow,2) > threshold(2)
                Optical_flow = [0;0];
                flag = 0;
            end
        end
    else
            Optical_flow = [0;0];
            flag = 0;
    end
end

