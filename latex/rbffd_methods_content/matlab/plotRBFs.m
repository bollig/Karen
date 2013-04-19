function[]=plotRBFs()

x = -2:0.01:2;
r = abs(x); 
e = 1; 
fontsize = 24; 
linewidth=3;

figure(1)
p1=plot(x,MQ(r,e),'LineWidth',linewidth); 
set(gca,'FontSize',fontsize);
axis([-2 2 0.5 2.5]);
title('MQ');
xlabel('r');
ylabel('\Phi(r)');
%grid on; 
print -deps mq_rbf.eps

figure(2)
p2=plot(x,IMQ(r,e),'LineWidth',linewidth); 
set(gca,'FontSize',fontsize);
axis([-2 2 0 1.5]);
title('IMQ');
xlabel('r');
ylabel('\Phi(r)');
%grid on; 
print -deps imq_rbf.eps

figure(3)
p3=plot(x,GA(r,e),'LineWidth',linewidth); 
set(gca,'FontSize',fontsize);
axis([-2 2 -0.5 1.5]);
title('GA');
xlabel('r');
ylabel('\Phi(r)');
%grid on; 
print -deps ga_rbf.eps

figure(4)
p4=plot(x,TPS(r,e),'LineWidth',linewidth); 
set(gca,'FontSize',fontsize);
axis([-2 2 -0.5 1.5]);
title('TPS');
xlabel('r');
ylabel('\Phi(r)');
%grid on; 
print -deps tps_rbf.eps

figure(5)
p5=plot(x,W2(r,e),'LineWidth',linewidth); 
set(gca,'FontSize',fontsize);
axis([-2 2 -0.5 1.5]);
title('W2');
xlabel('r');
ylabel('\Phi(r)');
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperSize', [4 4]);
print -deps w2_rbf.eps
%grid on; 
end

function[phi] = MQ(r,eps)
    phi=sqrt(1+(eps*r).^2);
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