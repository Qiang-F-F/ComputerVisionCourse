A = [];
n = unidrnd(48,8,1);
for i = 1:48
    A = [A;[[left_2D(i,2:3),1]*right_2D(i,2),[left_2D(i,2:3),1]*right_2D(i,3),[left_2D(i,2:3),1]]];
    %A = [A;[[left_2D(n(i),2:3),1]*right_2D(n(i),2),[left_2D(n(i),2:3),1]*right_2D(n(i),3),[left_2D(n(i),2:3),1]]];
end
[U,S,V] = svd(A);
S(9,9) = 0;
A = U*S*V';
[U,S,V] = svd(A);
F_v = [V(1:3,9),V(4:6,9),V(7:9,9)];

[U,S,V] = svd(F_v);
S(3,3) = 0;
F_v = U*S*V';

