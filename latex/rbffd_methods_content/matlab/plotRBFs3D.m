function[]=plotRBFs3D()

N = 100; 
pnorm = 2;
[x,y,z] = meshgrid(linspace(-2,2,N),linspace(-2,2,N),linspace(-2,2,N));
%y = meshgrid(linspace(-2,2,10));
r = sqrt(abs(x).^2 + abs(y).^2 + abs(z).^2);
e = 1; 
fontsize = 24; 
linewidth=1;

if 0
figure(1)
v=MQ(r,e);
isoval=2.4;
plotVolume(x,y,z,v,isoval);

colorbar
set(gca,'FontSize',fontsize);
title('MQ');
xlabel('x');
ylabel('y');
zlabel('z');
print -dpng mq_rbf3d.png


figure(2)
v=W2(r,e);
isoval=2.4;
plotVolume(x,y,z,v,isoval);

colorbar
set(gca,'FontSize',fontsize);
title('W2');
xlabel('x');
ylabel('y');
zlabel('z');
print -dpng w2_rbf3d.png
end

figure(3)
v=GA(r,e);
isoval=GA(2,e);
plotVolumeInv(x,y,z,v,isoval);

colorbar
set(gca,'FontSize',fontsize);
title('GA');
xlabel('x');
ylabel('y');
zlabel('z');
print -dpng ga_rbf3d.png
print -depsc2 ga_rbf3d.eps

return

figure(2)
p2=mesh(x,y,IMQ(r,e),'LineWidth',linewidth);
set(gca,'FontSize',fontsize);
shading interp
set(gcf,'colormap',winter);
axis([-2 2 -2 2 0.25 1]);
title('IMQ');
xlabel('r');
ylabel('\Phi(r)');
%grid on; 
print -deps imq_rbf2d.eps


figure(3)
p3=mesh(x,y,GA(r,e),'LineWidth',linewidth); 
set(gca,'FontSize',fontsize);
shading interp
set(gcf,'colormap',winter);
axis([-2 2 -2 2 0 1]);
title('GA');
xlabel('r');
ylabel('\Phi(r)');
%grid on; 
print -deps ga_rbf2d.eps

[x,y] = meshgrid(linspace(-1.25,1.25,N/2),linspace(-1.25,1.25,N/2));
%y = meshgrid(linspace(-2,2,10));
r = sqrt(abs(x.^2) + abs(y.^2))

figure(4)
p4=mesh(x,y,TPS(r,e),'LineWidth',linewidth); 
set(gca,'FontSize',fontsize);
shading interp
set(gcf,'colormap',winter);
axis([-1 1 -1 1 -0.5 1.5]);
title('TPS');
xlabel('r');
ylabel('\Phi(r)');
%grid on; 
print -deps tps_rbf2d.eps

figure(5)
p5=mesh(x,y,W2(r,e),'LineWidth',linewidth); 
set(gca,'FontSize',fontsize);
shading interp
set(gcf,'colormap',winter);
axis([-1 1 -1 1 -0.5 1.5]);
title('W2');
xlabel('r');
ylabel('\Phi(r)');
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperSize', [4 4]);
print -deps w2_rbf2d.eps
%grid on; 
end

function[phi] = MQ(r,eps)
    phi=sqrt(1+(eps.*r).^2);
end

function[phi] = IMQ(r,eps)
    phi=1./(sqrt(1.+(eps.*r).^2));
end

function[phi] = GA(r,eps)
    phi=exp(-(eps.*r).^2);
end

function[phi] = TPS(r,eps)
    phi=(r.^2) .* log(r);
end

function[phi] = W2(r,eps)
    phi=((1-eps.*r).^4) .* (4.*eps.*r + 1);
end

function[] = plotVolume(x,y,z,v,isoval)

colormap(jet);
cmap = get(gcf,'colormap');
boundaryColor = cmap(1,:);
invmap = flipud(cmap);
set(gcf,'colormap',invmap);

[x1,y1,z1,v1] = subvolume(x,y,z,v,[nan, nan, 0, nan, nan, nan]);
[x2,y2,z2,v2] = subvolume(x,y,z,v,[0, nan, nan, nan, nan, nan]);
[x3,y3,z3,v3] = subvolume(x,y,z,v,[nan, nan, nan, nan, nan, 0]);

p1=patch(isocaps(x1,y1,z1,v1, isoval, 'below'));
isonormals(x,y,z,v,p1)
set(p1,'FaceColor','interp','EdgeColor','none');
p2=patch(isosurface(x1,y1,z1,v1, isoval));
isonormals(x,y,z,v,p2)
set(p2,'FaceColor',boundaryColor,'EdgeColor','none');

p3=patch(isocaps(x2,y2,z2,v2, isoval, 'below'));
isonormals(x,y,z,v,p3)
set(p3,'FaceColor','interp','EdgeColor','none');
p4=patch(isosurface(x2,y2,z2,v2, isoval));
isonormals(x,y,z,v,p4)
set(p4,'FaceColor',boundaryColor,'EdgeColor','none');

p5=patch(isocaps(x3,y3,z3,v3, isoval, 'below'));
isonormals(x,y,z,v,p5)
set(p5,'FaceColor','interp','EdgeColor','none');
p6=patch(isosurface(x3,y3,z3,v3, isoval));
isonormals(x,y,z,v,p6)
set(p6,'FaceColor',boundaryColor,'EdgeColor','none');

%shading interp;

grid on; 
daspect([1,1,1]);
view(3);
camlight;lighting phong
%axis([-2 2 -2 2 1 3.0]);

end

function[] = plotVolumeInv(x,y,z,v,isoval)

colormap(jet);
cmap = get(gcf,'colormap');
boundaryColor = cmap(1,:);
invmap = flipud(cmap);
set(gcf,'colormap',cmap);

[x1,y1,z1,v1] = subvolume(x,y,z,v,[nan, nan, 0, nan, nan, nan]);
[x2,y2,z2,v2] = subvolume(x,y,z,v,[0, nan, nan, nan, nan, nan]);
[x3,y3,z3,v3] = subvolume(x,y,z,v,[nan, nan, nan, nan, nan, 0]);

p1=patch(isocaps(x1,y1,z1,v1, isoval, 'above'));
isonormals(x,y,z,v,p1)
set(p1,'FaceColor','interp','EdgeColor','none');
p2=patch(isosurface(x1,y1,z1,v1, isoval));
isonormals(x,y,z,v,p2)
set(p2,'FaceColor',boundaryColor,'EdgeColor','none');

p3=patch(isocaps(x2,y2,z2,v2, isoval, 'above'));
isonormals(x,y,z,v,p3)
set(p3,'FaceColor','interp','EdgeColor','none');
p4=patch(isosurface(x2,y2,z2,v2, isoval));
isonormals(x,y,z,v,p4)
set(p4,'FaceColor',boundaryColor,'EdgeColor','none');

p5=patch(isocaps(x3,y3,z3,v3, isoval, 'above'));
isonormals(x,y,z,v,p5)
set(p5,'FaceColor','interp','EdgeColor','none');
p6=patch(isosurface(x3,y3,z3,v3, isoval));
isonormals(x,y,z,v,p6)
set(p6,'FaceColor',boundaryColor,'EdgeColor','none');

hold on; 
%plot([0 0 0], [-2 0 0], '-.m', 'LineWidth', 3);
plot3([0 0], [0 -2], [0 0], '-.m', 'LineWidth', 2);
plot3([0 -2], [0 0], [0 0], '-.m', 'LineWidth', 2);
plot3([0 0], [0 0], [0 2], '-.m', 'LineWidth', 2);

t = linspace(0, 0, 50);
p = linspace(-pi/2, 0, 50);
r = 2; 
x = r.*sin(p).*cos(t);
y = r.*sin(p).*sin(t);
z = r.*cos(p);
plot3(x,y,z,'-.m', 'LineWidth',2);
t = linspace(pi/2, pi/2, 50);
p = linspace(-pi/2, 0, 50);
r = 2; 
x = r.*sin(p).*cos(t);
y = r.*sin(p).*sin(t);
z = r.*cos(p);
plot3(x,y,z,'-.m', 'LineWidth',2);
t = linspace(0, pi/2, 50);
p = linspace(-pi/2, -pi/2, 50);
r = 2; 
x = r.*sin(p).*cos(t);
y = r.*sin(p).*sin(t);
z = r.*cos(p);
plot3(x,y,z,'-.m', 'LineWidth',2);
%line([0 0 0], [0 0 2], 'LineWidth', 4, 'Color', [1, 0, 0]); 
%line([0 0 0], [-2 0 0], 'LineWidth', 4, 'Color', [1, 0, 0]); 


%shading interp;

grid on; 
daspect([1,1,1]);
view(3);
camlight(0,30);lighting phong
%axis([-2 2 -2 2 1 3.0]);

end