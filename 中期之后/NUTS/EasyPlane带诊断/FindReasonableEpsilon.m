function [epsilon] = FindReasonableEpsilon(x,T)

epsilon=1;
p=randn(2,1);

[x_temp,p_temp]=Leapfrog(x,p,epsilon);

a=2*(Boltzmann(x_temp,T)/Boltzmann(x,T)>0.5)-1;

while (Boltzmann(x_temp,T)/Boltzmann(x,T))^a>2^(-a)

    epsilon=2^a*epsilon;
    [x_temp,p_temp]=Leapfrog(x,p,epsilon);

end

end

