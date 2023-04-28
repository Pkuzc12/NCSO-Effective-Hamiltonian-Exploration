n=4;
lattice=latticeGrt(n);
G=graph;
x=[];
y=[];
z=[];
for i=1:1:n
for j=1:1:n
G=addnode(G,{convertStringsToChars("["+num2str(i)+","+num2str(j)+",left]")});
x=[x,sqrt(3)*i+sqrt(3)/2*j];
y=[y,3/2*j];
end
end
for i=1:1:n
for j=1:1:n
G=addnode(G,{convertStringsToChars("["+num2str(i)+","+num2str(j)+",right]")});
x=[x,sqrt(3)*i+sqrt(3)/2*j+sqrt(3)/2];
y=[y,3/2*j+1/2];
end
end
for i=1:1:n
for j=1:1:n
for k=1:1:1
G=addedge(G,[n*(i-1)+j],[n*(lattice(i,j).left.neighbor2(k,1)-1)+lattice(i,j).left.neighbor2(k,2)]);
end
for k=4:1:4
G=addedge(G,[n*(i-1)+j],[n*(lattice(i,j).left.neighbor2(k,1)-1)+lattice(i,j).left.neighbor2(k,2)]);
end
end
end
for i=1:1:n
for j=1:1:n
for k=1:1:1
G=addedge(G,[n*n+n*(i-1)+j],[n*n+n*(lattice(i,j).right.neighbor2(k,1)-1)+lattice(i,j).right.neighbor2(k,2)]);
end
for k=4:1:4
G=addedge(G,[n*n+n*(i-1)+j],[n*n+n*(lattice(i,j).right.neighbor2(k,1)-1)+lattice(i,j).right.neighbor2(k,2)]);
end
end
end
plot(G,'XData',x,'YData',y);