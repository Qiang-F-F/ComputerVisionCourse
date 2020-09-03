clear
vid=videoinput('macvideo');      
%preview(vid); 
triggerconfig(vid, 'manual');
start(vid);
pause(2);
video = uint8([]);

    
%x x_position;y_position;x_speed;y_speed
%x_i+1 = A*x_i
%z=I*x
A = [1,0,1,0;0,1,0,1;0,0,1,0;0,0,0,1];
%Q = 3600*eye(4);
Q = [3600,0,1800,0;0,3600,0,1800;1800,0,900,0;0,1800,0,900];
R = 900;
%data capture
%camera;
N = 1000;

x_P = [randi(1280,1,N);randi(720,1,N);round(mvnrnd([0,0],[100,0;0,100],N)')];
P_w = [];

figure(1);

while 1
    tic;
    a=getsnapshot(vid);           
    flushdata(vid);               
    current_f=double(ycbcr2rgb(a));
    
    noise = mvnrnd([0 0 0 0],Q,N)';
    x_P_update = round(A*x_P+noise);
    P_w = zeros(1,N);
    valid_index = ~(x_P_update(1,:)<1 | x_P_update(1,:)>1280| x_P_update(2,:)<1| x_P_update(2,:)>720);
    valid_x_update = x_P_update(:,valid_index);
    %z_update = zeros(1,N);
    z_update = calculate_d(current_f,valid_x_update);
    P_w(valid_index) = (1/sqrt(2*pi*R)) * exp(-z_update.^2./(2*R));
    P_w = P_w./sum(P_w);
    for i = 1 : N
        x_P(:,i) = x_P_update(:,find(rand <= cumsum(P_w),1));   % ????????????
    end
    x = mean(x_P,2);
    toc;
    clf;
    imshow(uint8(current_f));
    hold on;
    %plot(x_P(1,:),x_P(2,:),'*','color','b');
    plot(x(1),x(2),'x','color','g');
    pause(0.01);
    
    
end
delete(vid);

