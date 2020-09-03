%This part is to determine the threshold for the residual fitting error
read_data;
windowsize_c = 5;
windowsize_r = 5;
windowsize_t = 5;
t = 3;
error = [];
for c = 1+(windowsize_c-1)/2:200-(windowsize_c-1)/2
    for r = 1+(windowsize_r-1)/2:200-(windowsize_r-1)/2
        if c == 200-(windowsize_c-1)/2&r==200-(windowsize_r-1)/2
            hahah =1;
        end
        residual = SurfaceFitting_test(c,r,t,windowsize_c,windowsize_r,windowsize_t,seq_1);
        error = [error,norm(residual,2)];
    end
end

figure(1);
plot(1:length(error),error);