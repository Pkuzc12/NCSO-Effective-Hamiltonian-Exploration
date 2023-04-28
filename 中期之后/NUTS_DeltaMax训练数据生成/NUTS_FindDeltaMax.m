function [Delta_max] = NUTS_FindDeltaMax(parameter,otherparameter)

Delta_max_up=100;
Delta_max_down=-100;

while abs(Delta_max_up-Delta_max_down)>0.01

    Delta_max=1/2*(Delta_max_up+Delta_max_down);

    flag=NUTS_b(parameter,otherparameter,Delta_max);

    if flag

        Delta_max_down=Delta_max;

    else

        Delta_max_up=Delta_max;

    end

end

Delta_max=1/2*(Delta_max_up+Delta_max_down);

end

