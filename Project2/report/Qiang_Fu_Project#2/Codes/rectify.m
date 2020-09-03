t_star_l = -t'./norm(t,2);
temp = -[t_star_l(2),-t_star_l(1),0]./(t_star_l(1)^2+t_star_l(2)^2)^0.5;
R_rec_l = [t_star_l;temp;cross(t_star_l,temp)];

R_rec_r = R_rec_l*R;
il = imread('./project2_data/faceimage/left_face.jpg');
ir = imread('./project2_data/faceimage/right_face.jpg');
image_l = uint8(zeros(1536,2048,3));
image_r = uint8(zeros(1536,2048,3));
W = (Wl+Wr)./2;
for i = 1:1536%back forward mapping
    for j = 1:2048
        temp = Wl*R_rec_l^-1*W^-1*[j;i;1];
        temp_r = Wr*R_rec_r^-1*W^-1*[j;i;1];
        temp = temp./temp(3);
        temp_r = temp_r./temp_r(3);
        temp = round(temp);
        temp_r = round(temp_r);
        if temp(1)>=1 && temp(2)>=1 && temp(1)<=2048 && temp(2)<=1536
            image_l(i,j,:) = il(temp(2),temp(1),:);
        end
        if temp_r(1)>=1 && temp_r(2)>=1 && temp_r(1)<=2048 && temp_r(2)<=1536
            image_r(i,j,:) = ir(temp_r(2),temp_r(1),:);
        end
    end
end
draw;
