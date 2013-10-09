%% M2050 and M2070

BW = 144 %GBytes/s
GFLOPS = 515 %GFLOP/s (double)

figure(1)
plotRoofline(BW,GFLOPS, 'NVidia M2050, M2070')


%% K20

BW = 208 %GBytes/s
GFLOPS = 1170 %GFLOPs

figure(2)
plotRoofline(BW,GFLOPS, 'NVidia K20')