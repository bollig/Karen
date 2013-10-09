
function [] = plotRoofline(B, G, title1)

S = [1/32 1/16 1/8 1/4 1/2 1 2 4 8 16];

I = G/B; 

X1 = [S(S<I) I];
X2 = [I S(S>I)];

Y = B * X1;
Z = G * ones(size(X2)); 

SpMV_Peak = B*0.25

plot(log2(X1), log2(Y),'r-', 'LineWidth', 5); 
hold on; 
label1 = sprintf('%d GByte/sec',B);
label2 = sprintf('%d GFLOP/sec',G);

t1 = text(-2,log2(B/4)+0.5,label1,'FontSize', 18);
set(t1, 'rotation', 40);

plot(log2(X2), log2(Z),'b-', 'LineWidth', 5); 

t2 = text(max(log2(X2))-2,log2(G)+0.275,label2,'FontSize', 18);
hold off; 
%axis([min(log2(X1)) max(log2(X2)) min(log2(Y)) nextpow2(G)]);
axis([min(log2(X1)) max(log2(X2)) min(log2(Y)) 11]);

xt = get(gca, 'XTick');
yt = get(gca, 'YTick');
set (gca, 'YTickLabel', 2.^yt, 'FontSize', 18);
set (gca, 'XTickLabel', 2.^xt, 'FontSize', 18);

title(title1);
ylabel('Peak Possible GFLOP/sec (DP)');
xlabel('Operational Intensity (FLOPs:Byte)');

grid on
end