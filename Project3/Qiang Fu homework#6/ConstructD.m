function D = ConstructD(windowsize_c,windowsize_r,windowsize_t)
    D = [];
    for k = -(windowsize_t-1)/2:(windowsize_t-1)/2         
        for i = -(windowsize_c-1)/2:(windowsize_c-1)/2
            for j = -(windowsize_r-1)/2:(windowsize_r-1)/2
            D = [D;1 i j k i^2 i*j j^2 j*k k^2 i*k i^3 i^2*j i*j^2 j^3 j^2*k j*k^2 k^3 i^2*k i*k^2 i*j*k];
            end
        end
    end

end