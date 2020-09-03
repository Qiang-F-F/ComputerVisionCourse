read_data;

windowsize_c = 5;
windowsize_r = 5;
windowsize_t = 5;
t = 3;
threshold = [1,20];

figure(3);
imshow(seq1_frame3);
hold on;
interval = 10;
OF = [];
pt = [];
for i = 2:38
    for j = 2:38
        P = [1+(j-1)*5,1+(i-1)*5];
        optical_flow_block = [0;0];
        for m = 1:5
            for n = 1:5
                [Optical_flow,flag] = TheSecondMethod(P(1)+m-1,P(2)+n-1,t,windowsize_c,windowsize_r,windowsize_t,seq_1,threshold);
                if flag ~= 0
                    optical_flow_block = optical_flow_block+Optical_flow;
                else
                    optical_flow_block = optical_flow_block+[0;0];
                end 
            end
        end
        OF = [OF;optical_flow_block'./5];
        pt = [pt;5*(i-1)+2,5*(j-1)+2];
    end
end
for i = 1:1369
    quiver(pt(i,1),pt(i,2),OF(i,1),OF(i,2),'r');
end