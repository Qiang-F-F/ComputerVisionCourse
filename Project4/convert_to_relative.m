function Cr = convert_to_relative(p,c)
    Cr = [];
    for i = 1:length(p(:,1))
        Cr = [Cr;p(i,1:2)-c];
    end
end

