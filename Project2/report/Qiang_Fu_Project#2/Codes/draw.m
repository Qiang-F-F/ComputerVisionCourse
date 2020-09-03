pts_left = load('./project2_data/faceimage/pts_left.txt');
pts_right = load('./project2_data/faceimage/pts_right.txt');
n = [11,12,13,14,15,16,17,18,19,20,21,22,23,25,27,29];
N = length(n);
%n =1:N;
syms x y;

figure(4);
subplot(2,2,1);
imshow(il);hold on;
subplot(2,2,2);
imshow(ir);hold on;
subplot(2,2,3);
imshow(image_l);hold on;
subplot(2,2,4);
imshow(image_r);hold on;
for i = 1:N
    p_l = [pts_left(n(i),2:3),1]';
    p_r = [pts_right(n(i),2:3),1]';
    e_l = F*p_r;
    e_r = F'*p_l;
    
    F_r = (W^-1)'*[0 0 0;0 0 norm(t,2);0 -norm(t,2) 0]*W^-1;
    p_l_r = W*R_rec_l*Wl^-1*p_l;
    p_l_r = p_l_r./p_l_r(3);
    p_r_r = W*R_rec_r*Wr^-1*p_r;
    p_r_r = p_r_r./p_r_r(3);
    e_l_r = F_r*p_r_r;
    e_r_r = F_r'*p_l_r;
    
    subplot(2,2,1);
    plot(p_l(1),p_l(2),'*','color','r');hold on;
    fimplicit([x,y,1]*e_l,'r');hold on;
    
    subplot(2,2,2);
    plot(p_r(1),p_r(2),'*','color','r');hold on;
    fimplicit([x,y,1]*e_r,'r');hold on;
 
    subplot(2,2,3);
    plot(p_l_r(1),p_l_r(2),'*','color','r');hold on;
    refline(-e_l_r(1)/e_l_r(2),-e_l_r(3)/e_l_r(2));hold on;
   
    subplot(2,2,4);
    plot(p_r_r(1),p_r_r(2),'*','color','r');hold on;
    refline(-e_r_r(1)/e_r_r(2),-e_r_r(3)/e_r_r(2));hold on;
   
end