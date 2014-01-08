%% M2050 and M2070

BW = 144 %GBytes/s
GFLOPS = 515 %GFLOP/s (double)

figure(1)
plotRoofline(BW,GFLOPS, 'NVidia M2050, M2070')
 
hold on

%% K20

BW = 208 %GBytes/s
GFLOPS = 1170 %GFLOPs

%figure(2)
plotRoofline(BW,GFLOPS, 'NVidia K20')
hold off

%SOURCE: http://download.intel.com/newsroom/kits/xeon/phi/pdfs/Intel-Xeon-Phi-Coprocessor_ProductBrief.pdf
BW = 320 %GBytes/s
GFLOPS = 1011 %GFLOPs

figure(3)
plotRoofline(BW,GFLOPS, 'Intel Xeon Phi 5110P (B1)')