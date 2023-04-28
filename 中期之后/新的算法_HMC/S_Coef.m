function [coef] = S_Coef(chart,n,J1,J1p,J2,J2p,J3,K,G,Gs,Kp,Gp,Gps,B,D)

coef=zeros(6*n*n);
U=[[1/sqrt(6),-1/sqrt(2),1/sqrt(3)];[1/sqrt(6),1/sqrt(2),1/sqrt(3)];[-sqrt(2/3),0,1/sqrt(3)]];
Kitaev=[[0,G,Gs];[G,0,Gs];[Gs,Gs,K]];
KitaevP=[[0,Gp,Gps];[Gp,0,Gps];[Gps,Gps,Kp]];
order=[[[0,1,0];[0,0,1];[1,0,0]];[[0,0,1];[1,0,0];[0,1,0]];[[1,0,0];[0,1,0];[0,0,1]]];

for i=1:1:n
    for j=1:1:n

        coef(((i-1)*n+j-1)*6+2,((i-1)*n+j-1)*6+2)=B;
        coef(((i-1)*n+j-1)*6+3,((i-1)*n+j-1)*6+3)=D;
        coef(((i-1)*n+j-1)*6+5,((i-1)*n+j-1)*6+5)=B;
        coef(((i-1)*n+j-1)*6+6,((i-1)*n+j-1)*6+6)=D;

        for k=1:1:2
            nei=chart(i,j).left.neighbor(k,:);
            coef(((i-1)*n+j-1)*6+1,((nei(1)-1)*n+nei(2)-1)*6+4)=coef(((i-1)*n+j-1)*6+1,((nei(1)-1)*n+nei(2)-1)*6+4)+1/4*J1p;
            coef(((i-1)*n+j-1)*6+2,((nei(1)-1)*n+nei(2)-1)*6+5)=coef(((i-1)*n+j-1)*6+2,((nei(1)-1)*n+nei(2)-1)*6+5)+1/4*J1p;
            coef(((i-1)*n+j-1)*6+3,((nei(1)-1)*n+nei(2)-1)*6+6)=coef(((i-1)*n+j-1)*6+3,((nei(1)-1)*n+nei(2)-1)*6+6)+1/4*J1p;
            nei=chart(i,j).right.neighbor(k,:);
            coef(((i-1)*n+j-1)*6+4,((nei(1)-1)*n+nei(2)-1)*6+1)=coef(((i-1)*n+j-1)*6+4,((nei(1)-1)*n+nei(2)-1)*6+1)+1/4*J1p;
            coef(((i-1)*n+j-1)*6+5,((nei(1)-1)*n+nei(2)-1)*6+2)=coef(((i-1)*n+j-1)*6+5,((nei(1)-1)*n+nei(2)-1)*6+2)+1/4*J1p;
            coef(((i-1)*n+j-1)*6+6,((nei(1)-1)*n+nei(2)-1)*6+3)=coef(((i-1)*n+j-1)*6+6,((nei(1)-1)*n+nei(2)-1)*6+3)+1/4*J1p;
        end
        nei=chart(i,j).left.neighbor(3,:);
        coef(((i-1)*n+j-1)*6+1,((nei(1)-1)*n+nei(2)-1)*6+4)=coef(((i-1)*n+j-1)*6+1,((nei(1)-1)*n+nei(2)-1)*6+4)+1/4*J1;
        coef(((i-1)*n+j-1)*6+2,((nei(1)-1)*n+nei(2)-1)*6+5)=coef(((i-1)*n+j-1)*6+2,((nei(1)-1)*n+nei(2)-1)*6+5)+1/4*J1;
        coef(((i-1)*n+j-1)*6+3,((nei(1)-1)*n+nei(2)-1)*6+6)=coef(((i-1)*n+j-1)*6+3,((nei(1)-1)*n+nei(2)-1)*6+6)+1/4*J1;
        nei=chart(i,j).right.neighbor(3,:);
        coef(((i-1)*n+j-1)*6+4,((nei(1)-1)*n+nei(2)-1)*6+1)=coef(((i-1)*n+j-1)*6+4,((nei(1)-1)*n+nei(2)-1)*6+1)+1/4*J1;
        coef(((i-1)*n+j-1)*6+5,((nei(1)-1)*n+nei(2)-1)*6+2)=coef(((i-1)*n+j-1)*6+5,((nei(1)-1)*n+nei(2)-1)*6+2)+1/4*J1;
        coef(((i-1)*n+j-1)*6+6,((nei(1)-1)*n+nei(2)-1)*6+3)=coef(((i-1)*n+j-1)*6+6,((nei(1)-1)*n+nei(2)-1)*6+3)+1/4*J1;

        nei=chart(i,j).left.neighbor2(1,:);
        coef(((i-1)*n+j-1)*6+1,((nei(1)-1)*n+nei(2)-1)*6+1)=coef(((i-1)*n+j-1)*6+1,((nei(1)-1)*n+nei(2)-1)*6+1)+1/4*J2p;
        coef(((i-1)*n+j-1)*6+2,((nei(1)-1)*n+nei(2)-1)*6+2)=coef(((i-1)*n+j-1)*6+2,((nei(1)-1)*n+nei(2)-1)*6+2)+1/4*J2p;
        coef(((i-1)*n+j-1)*6+3,((nei(1)-1)*n+nei(2)-1)*6+3)=coef(((i-1)*n+j-1)*6+3,((nei(1)-1)*n+nei(2)-1)*6+3)+1/4*J2p;
        nei=chart(i,j).right.neighbor2(1,:);
        coef(((i-1)*n+j-1)*6+4,((nei(1)-1)*n+nei(2)-1)*6+1)=coef(((i-1)*n+j-1)*6+4,((nei(1)-1)*n+nei(2)-1)*6+1)+1/4*J2p;
        coef(((i-1)*n+j-1)*6+5,((nei(1)-1)*n+nei(2)-1)*6+2)=coef(((i-1)*n+j-1)*6+5,((nei(1)-1)*n+nei(2)-1)*6+2)+1/4*J2p;
        coef(((i-1)*n+j-1)*6+6,((nei(1)-1)*n+nei(2)-1)*6+3)=coef(((i-1)*n+j-1)*6+6,((nei(1)-1)*n+nei(2)-1)*6+3)+1/4*J2p;
        nei=chart(i,j).left.neighbor2(4,:);
        coef(((i-1)*n+j-1)*6+1,((nei(1)-1)*n+nei(2)-1)*6+1)=coef(((i-1)*n+j-1)*6+1,((nei(1)-1)*n+nei(2)-1)*6+1)+1/4*J2p;
        coef(((i-1)*n+j-1)*6+2,((nei(1)-1)*n+nei(2)-1)*6+2)=coef(((i-1)*n+j-1)*6+2,((nei(1)-1)*n+nei(2)-1)*6+2)+1/4*J2p;
        coef(((i-1)*n+j-1)*6+3,((nei(1)-1)*n+nei(2)-1)*6+3)=coef(((i-1)*n+j-1)*6+3,((nei(1)-1)*n+nei(2)-1)*6+3)+1/4*J2p;
        nei=chart(i,j).right.neighbor2(4,:);
        coef(((i-1)*n+j-1)*6+4,((nei(1)-1)*n+nei(2)-1)*6+1)=coef(((i-1)*n+j-1)*6+4,((nei(1)-1)*n+nei(2)-1)*6+1)+1/4*J2p;
        coef(((i-1)*n+j-1)*6+5,((nei(1)-1)*n+nei(2)-1)*6+2)=coef(((i-1)*n+j-1)*6+5,((nei(1)-1)*n+nei(2)-1)*6+2)+1/4*J2p;
        coef(((i-1)*n+j-1)*6+6,((nei(1)-1)*n+nei(2)-1)*6+3)=coef(((i-1)*n+j-1)*6+6,((nei(1)-1)*n+nei(2)-1)*6+3)+1/4*J2p;
        for k=2:1:3
            nei=chart(i,j).left.neighbor2(k,:);
            coef(((i-1)*n+j-1)*6+1,((nei(1)-1)*n+nei(2)-1)*6+1)=coef(((i-1)*n+j-1)*6+1,((nei(1)-1)*n+nei(2)-1)*6+1)+1/4*J2;
            coef(((i-1)*n+j-1)*6+2,((nei(1)-1)*n+nei(2)-1)*6+2)=coef(((i-1)*n+j-1)*6+2,((nei(1)-1)*n+nei(2)-1)*6+2)+1/4*J2;
            coef(((i-1)*n+j-1)*6+3,((nei(1)-1)*n+nei(2)-1)*6+3)=coef(((i-1)*n+j-1)*6+3,((nei(1)-1)*n+nei(2)-1)*6+3)+1/4*J2;
            nei=chart(i,j).right.neighbor2(k,:);
            coef(((i-1)*n+j-1)*6+4,((nei(1)-1)*n+nei(2)-1)*6+4)=coef(((i-1)*n+j-1)*6+4,((nei(1)-1)*n+nei(2)-1)*6+4)+1/4*J2;
            coef(((i-1)*n+j-1)*6+5,((nei(1)-1)*n+nei(2)-1)*6+5)=coef(((i-1)*n+j-1)*6+5,((nei(1)-1)*n+nei(2)-1)*6+5)+1/4*J2;
            coef(((i-1)*n+j-1)*6+6,((nei(1)-1)*n+nei(2)-1)*6+6)=coef(((i-1)*n+j-1)*6+6,((nei(1)-1)*n+nei(2)-1)*6+6)+1/4*J2;
        end
        for k=5:1:6
            nei=chart(i,j).left.neighbor2(k,:);
            coef(((i-1)*n+j-1)*6+1,((nei(1)-1)*n+nei(2)-1)*6+1)=coef(((i-1)*n+j-1)*6+1,((nei(1)-1)*n+nei(2)-1)*6+1)+1/4*J2;
            coef(((i-1)*n+j-1)*6+2,((nei(1)-1)*n+nei(2)-1)*6+2)=coef(((i-1)*n+j-1)*6+2,((nei(1)-1)*n+nei(2)-1)*6+2)+1/4*J2;
            coef(((i-1)*n+j-1)*6+3,((nei(1)-1)*n+nei(2)-1)*6+3)=coef(((i-1)*n+j-1)*6+3,((nei(1)-1)*n+nei(2)-1)*6+3)+1/4*J2;
            nei=chart(i,j).right.neighbor2(k,:);
            coef(((i-1)*n+j-1)*6+4,((nei(1)-1)*n+nei(2)-1)*6+4)=coef(((i-1)*n+j-1)*6+4,((nei(1)-1)*n+nei(2)-1)*6+4)+1/4*J2;
            coef(((i-1)*n+j-1)*6+5,((nei(1)-1)*n+nei(2)-1)*6+5)=coef(((i-1)*n+j-1)*6+5,((nei(1)-1)*n+nei(2)-1)*6+5)+1/4*J2;
            coef(((i-1)*n+j-1)*6+6,((nei(1)-1)*n+nei(2)-1)*6+6)=coef(((i-1)*n+j-1)*6+6,((nei(1)-1)*n+nei(2)-1)*6+6)+1/4*J2;
        end

        for k=1:1:3
            nei=chart(i,j).left.neighbor3(k,:);
            coef(((i-1)*n+j-1)*6+1,((nei(1)-1)*n+nei(2)-1)*6+4)=coef(((i-1)*n+j-1)*6+1,((nei(1)-1)*n+nei(2)-1)*6+4)+1/4*J3;
            coef(((i-1)*n+j-1)*6+2,((nei(1)-1)*n+nei(2)-1)*6+5)=coef(((i-1)*n+j-1)*6+2,((nei(1)-1)*n+nei(2)-1)*6+5)+1/4*J3;
            coef(((i-1)*n+j-1)*6+3,((nei(1)-1)*n+nei(2)-1)*6+6)=coef(((i-1)*n+j-1)*6+3,((nei(1)-1)*n+nei(2)-1)*6+6)+1/4*J3;
            nei=chart(i,j).right.neighbor3(k,:);
            coef(((i-1)*n+j-1)*6+4,((nei(1)-1)*n+nei(2)-1)*6+1)=coef(((i-1)*n+j-1)*6+4,((nei(1)-1)*n+nei(2)-1)*6+1)+1/4*J3;
            coef(((i-1)*n+j-1)*6+5,((nei(1)-1)*n+nei(2)-1)*6+2)=coef(((i-1)*n+j-1)*6+5,((nei(1)-1)*n+nei(2)-1)*6+2)+1/4*J3;
            coef(((i-1)*n+j-1)*6+6,((nei(1)-1)*n+nei(2)-1)*6+3)=coef(((i-1)*n+j-1)*6+6,((nei(1)-1)*n+nei(2)-1)*6+3)+1/4*J3;
        end


        nei=chart(i,j).left.neighbor(1,:);
        gross=inv(U)*inv(order(1:3,:))*KitaevP*order(1:3,:)*U;
        for s=1:1:3
            for t=1:1:3
                 coef(((i-1)*n+j-1)*6+s,((nei(1)-1)*n+nei(2)-1)*6+3+t)=coef(((i-1)*n+j-1)*6+s,((nei(1)-1)*n+nei(2)-1)*6+3+t)+gross(s,t);
            end
        end
        nei=chart(i,j).left.neighbor(2,:);
        gross=inv(U)*inv(order(4:6,:))*KitaevP*order(4:6,:)*U;
        for s=1:1:3
            for t=1:1:3
                 coef(((i-1)*n+j-1)*6+s,((nei(1)-1)*n+nei(2)-1)*6+3+t)=coef(((i-1)*n+j-1)*6+s,((nei(1)-1)*n+nei(2)-1)*6+3+t)+gross(s,t);
            end
        end
        nei=chart(i,j).left.neighbor(3,:);
        gross=inv(U)*inv(order(7:9,:))*Kitaev*order(7:9,:)*U;
        for s=1:1:3
            for t=1:1:3
                 coef(((i-1)*n+j-1)*6+s,((nei(1)-1)*n+nei(2)-1)*6+3+t)=coef(((i-1)*n+j-1)*6+s,((nei(1)-1)*n+nei(2)-1)*6+3+t)+gross(s,t);
            end
        end

        nei=chart(i,j).right.neighbor(1,:);
        gross=inv(U)*inv(order(1:3,:))*KitaevP*order(1:3,:)*U;
        for s=1:1:3
            for t=1:1:3
                 coef(((i-1)*n+j-1)*6+3+s,((nei(1)-1)*n+nei(2)-1)*6+t)=coef(((i-1)*n+j-1)*6+3+s,((nei(1)-1)*n+nei(2)-1)*6+t)+gross(s,t);
            end
        end
        nei=chart(i,j).right.neighbor(2,:);
        gross=inv(U)*inv(order(4:6,:))*KitaevP*order(4:6,:)*U;
        for s=1:1:3
            for t=1:1:3
                 coef(((i-1)*n+j-1)*6+3+s,((nei(1)-1)*n+nei(2)-1)*6+t)=coef(((i-1)*n+j-1)*6+s+3,((nei(1)-1)*n+nei(2)-1)*6+t)+gross(s,t);
            end
        end
        nei=chart(i,j).left.neighbor(3,:);
        gross=inv(U)*inv(order(7:9,:))*Kitaev*order(7:9,:)*U;
        for s=1:1:3
            for t=1:1:3
                 coef(((i-1)*n+j-1)*6+3+s,((nei(1)-1)*n+nei(2)-1)*6+t)=coef(((i-1)*n+j-1)*6+3+s,((nei(1)-1)*n+nei(2)-1)*6+t)+gross(s,t);
            end
        end
    end
end
end

