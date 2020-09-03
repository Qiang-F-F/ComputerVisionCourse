function [Ic,Ir,It] =Numerical_method(c,r,t,seq) 
    Ic = double(seq(r,c,t)-seq(r,c-1,t));
    Ir = double(seq(r,c,t)-seq(r-1,c,t));
    It = double(seq(r,c,t)-seq(r,c,t-1));
    %{
    Icc = seq(r,c,t)-seq(r,c-1,t);
    Irc = seq(r,c,t)-seq(r,c-1,t);
    Itc = seq(r,c,t)-seq(r,c-1,t);
    Icr = seq(r,c,t)-seq(r,c-1,t);
    Irr = seq(r,c,t)-seq(r,c-1,t);
    Itr = seq(r,c,t)-seq(r,c-1,t);
    Ict = seq(r,c,t)-seq(r,c-1,t);
    Irt = seq(r,c,t)-seq(r,c-1,t);
    Itt = seq(r,c,t)-seq(r,c-1,t);
    %}
end