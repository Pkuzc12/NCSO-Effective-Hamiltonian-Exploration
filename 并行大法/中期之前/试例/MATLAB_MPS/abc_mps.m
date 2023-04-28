% parfor i = 1:2048
A = zeros(100,1);
parfor i = 1:100
    A(i) = sin(i*2*pi/20);
end
save myResult.mat A

