function [gradEb] = grad_Eb_Num(nei,x,n,J1,J1p,J2,J2p,J3,K,G,Gs,Kp,Gp,Gps,B,D,field)

gradEb=zeros(4,n*n);

for i=1:1:n
    for j=1:1:n
        for k=1:1:4
            x1=x;
            x2=x;
            x1(k,(i-1)*n+j)=x1(k,(i-1)*n+j)-0.001;
            x2(k,(i-1)*n+j)=x2(k,(i-1)*n+j)+0.001;
            gradEb(k,(i-1)*n+j)=500*(calculateEb(nei,x2,n,J1,J1p,J2,J2p,J3,K,G,Gs,Kp,Gp,Gps,B,D,field)-calculateEb(nei,x1,n,J1,J1p,J2,J2p,J3,K,G,Gs,Kp,Gp,Gps,B,D,field));
        end
    end
end

end

