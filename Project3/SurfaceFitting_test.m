function residual =SurfaceFitting_test(c,r,t,windowsize_c,windowsize_r,windowsize_t,seq) 
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
    a = D\J;
    residual = D*a-J;
end

