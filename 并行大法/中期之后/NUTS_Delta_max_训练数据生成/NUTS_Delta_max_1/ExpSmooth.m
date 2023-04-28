function [R_smooth] = ExpSmooth(R,stage_each_chain)

R_smooth=zeros(1,stage_each_chain);
R_smooth(1)=R(1);

alpha=0.2;

for i=2:1:stage_each_chain

    R_smooth(i)=alpha*R(i-1)+(1-alpha)*R_smooth(i-1);

end

