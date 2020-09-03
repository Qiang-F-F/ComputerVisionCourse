function C = feature_detetor(I1,I2,s_e,s,sigma)
    
    C = [];
    wide = int32(ceil(2*(trace(sigma)/16)^0.5));
    wide = idivide(wide,int32(2),'floor');
    wide = double(wide);
    
        v_s = double(vectorize(I1,s(1:2),4));
        for n = 1:(2*wide+1)^2
            P_temp = s_e(1:2)-[wide;wide]+double([mod(n,2*wide+1)-1;idivide(int32(n),int32(2*wide+1),'floor')]);
            if n == 1
               v = double(vectorize(I2,P_temp,4));
               SSD = (v_s-v)'*(v_s-v);
               SSD_min = SSD;
               P_min = P_temp;
            else
               v = double(vectorize(I2,P_temp,4));
               SSD = (v_s-v)'*(v_s-v);
               if SSD<SSD_min
                   P_min = P_temp;
                   SSD_min = SSD;
               end 
            end
        end
        C = [C;P_min'];
    
end