S_3D = [Structure(:,1:3),Structure(:,7),Structure(:,9),Structure(:,8),Structure(:,6),Structure(:,5),Structure(:,4),Structure(:,2)];
plot3(Structure(1,:),Structure(2,:),Structure(3,:),'*')
hold on;
plot3(S_3D(1,:),S_3D(2,:),S_3D(3,:),'-')
