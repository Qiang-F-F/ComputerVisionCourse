current = 1;
count = 0;
opticalflow_pack = [];
temp1 = [];
temp2 = [];
temp3 = [0,0];
temp4 = [];
p = [];
for i = 1:length(points(:,1))-1
    k = idivide(int32(points(i,1)),7,'ceil');
    if current ~= k 
        current = k;
    end
    temp1 = [temp1;optical_flows];
    temp2 = [temp2;points];
    count = count+1;
    if current ~= idivide(int32(points(i+1,1)),int32(7),'ceil')
        cc = 0;
        for jj = 1:count
            l = idivide(int32(temp2(jj,2)),7,'ceil');
            if c ~= l
                c = l;
            end
            temp3 = temp3+temp1(jj,:);
            cc = cc+1;
            if c ~= idivide(int32(temp2(jj+1,1)),int32(7),'ceil')
               p = [p;4+(k-1)*7,4+(l-1)*7]; 
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