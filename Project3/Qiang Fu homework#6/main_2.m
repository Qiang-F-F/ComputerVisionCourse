warning('off');
read_data;
%The first part is for the seq2
points = [];
optical_flows = [];
windowsize_c = 5;
windowsize_r = 5;
windowsize_t = 5;
t = 3;
threshold = [0.5,5];
D = ConstructD(windowsize_c,windowsize_r,windowsize_t);
for c = 1+(windowsize_c-1)/2:15:1201-(windowsize_c-1)/2
    for r = 1+(windowsize_r-1)/2:15:901-(windowsize_r-1)/2
        [Optical_flow,flag] = TheSecondMethod(c,r,t,windowsize_c,windowsize_r,windowsize_t,seq_2,threshold);
        %[Optical_flow,flag] = LK_opticalflow(c,r,t,windowsize_c,windowsize_r,seq_2,threshold);
        if flag == 1
           points = [points;c,r];
           optical_flows = [optical_flows;Optical_flow'];
        else
           points = [points;c,r];
           optical_flows = [optical_flows;0,0];
        end
    end
end


figure(1);
imshow(seq2_frame3);
hold on;
quiver(points(:,1),points(:,2),optical_flows(:,1),optical_flows(:,2),'y');
%{
current = 1;
count = 0;
opticalflow_pack = [];
temp1 = [];
temp2 = [];
temp3 = [];
temp4 = [];
p = [];
for i = 1:length(points(:,1))
    k = idivide(points(i,1),5,'ceil');
    if current ~= k 
        current = k;
    end
    temp1 = [temp1;optical_flows];
    temp2 = [temp2;points];
    count = count+1;
    if current ~= idivide(int32(points(i+1,1)),int32(5),'ceil')
        cc = 0;
        for jj = 1:count
            l = idivide(temp2(jj,2),5,'ceil');
            if c ~= l
                c = l;
            end
            temp3 = temp3+temp1(l,:);
            cc = cc+1;
            if c ~= idivide(int32(temp2(jj+1,1)),int32(5),'ceil')
               p = [p;3+(k-1)*5,3+(l-1)*5]; 
               opticalflow_pack = [opticalflow_pack;temp3./cc];
               cc = 0;
               temp3 = [0,0];
            end
        end
        count = 0;
        temp1 = [0,0];
        temp2 = [0,0];
    end 
end
%}