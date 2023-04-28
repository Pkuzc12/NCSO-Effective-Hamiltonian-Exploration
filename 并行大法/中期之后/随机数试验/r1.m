clear all
close all
clc

rng(1,'twister')

n=zeros(1,16);
parfor i=1:16
    n(i)=rand;

end

save random1.mat