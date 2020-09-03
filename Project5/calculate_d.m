function distance = calculate_d(img,x)
    r = double(diag(img(x(2,:),x(1,:),1)));
    g = double(diag(img(x(2,:),x(1,:),2)));
    b = double(diag(img(x(2,:),x(1,:),3)));
    distance = sqrt((r-255).^2+g.^2+b.^2);
    %img = double(img);
    %distance = sqrt((img(x(2),x(1),1)-255)^2+img(x(2),x(1),2)^2+img(x(2),x(1),3)^2);
end

