clear all
close all
clc

rng(2,'twister');

n=zeros(1,16);
parfor i=1:16
    n(i)=rand;

end

save random2.mat