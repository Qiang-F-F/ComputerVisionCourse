function v = vectorize(I,P,wide)
    v = I(P(2)-wide:P(2)+wide,P(1)-wide:P(1)+wide);
    v = reshape(v,(2*wide+1)^2,1);
end