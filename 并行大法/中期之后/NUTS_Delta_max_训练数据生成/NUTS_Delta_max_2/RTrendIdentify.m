function [flag,R_smooth] = RTrendIdentify(R,stage_each_chain)

R_smooth=ExpSmooth(R,stage_each_chain);

k=polyfit((stage_each_chain-4):1:stage_each_chain,R_smooth((stage_each_chain-4):stage_each_chain),1);

if (abs(k(1))<0.005) && (R_smooth(stage_each_chain)<1.25)

    flag=0;

else

    flag=1;

end

end

