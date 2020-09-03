left_2D = load("./project2_data/calibration/pts_2D_left.txt");
right_2D = load("./project2_data/calibration/pts_2D_right.txt");
pts_3D = load("./project2_data/calibration/pts_3D.txt");
using_left = 1;%camera calibration for the left one
RANSAC;
using_left = 0;%camera calibration for the right one
RANSAC;
R = Rl*Rr^-1;%calculating the relative rotation
t = tl-R*tr;%relative translation
F = (Wl^-1)'*[0 -t(3) t(2);t(3) 0 -t(1);-t(2) t(1) 0]'*R*Wr^-1;%calculating the fundamental matrix by definition
eight_points;%calculating the fundamental matrix by the 8-points method
error_1 = [];
error_2 = [];
for i = 1:48
    error_1 = [error_1,[left_2D(i,2:3),1]*F*[right_2D(i,2:3),1]'];%error of fundamental matrix from definition
    error_2 = [error_2,[left_2D(i,2:3),1]*F_v*[right_2D(i,2:3),1]'];%error of fundamental matrix from definition
end
figure();
plot(1:48,error_1,'color','r');
hold on;
plot(1:48,error_2,'color','b');
legend('Error of F from method 1','Error of F from method 2');
