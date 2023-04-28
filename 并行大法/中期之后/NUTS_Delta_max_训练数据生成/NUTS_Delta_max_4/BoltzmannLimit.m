function [Boltzmann] = BoltzmannLimit(x,kT,size,ES,parameter,limit)

Boltzmann=exp(limit/(kT)-CalculateEb(x,size,ES,parameter)/(kT));

end

