dft = csvread('dft.csv',1,3);
fft = csvread('fft.csv',1,3);
fft_comb = csvread('fft_comb.csv',1,3);
dft_par = csvread('dft_par.csv',1,3);
fft_opt = csvread('fft_opt.csv',1,3);
fft_parfor = csvread('fft_parfor.csv',1,3);
fft_tg = csvread('fft_tg.csv',1,3);

n = min(length(fft),min(length(fft_comb),min(length(fft_opt),min(length(fft_parfor),length(fft_tg)))));

d = min(length(dft),length(dft_par));

fft_tg_y = (fft(1:n,3)./fft_tg(1:n,3));

fft_parfor_y = fft(1:n,3)./fft_parfor(1:n,3);

fft_opt_y = fft(1:n,3)./fft_opt(1:n,3);

fft_comb_y = fft(1:n,3)./fft_comb(1:n,3);

fft_y = fft(1:n,3)./fft(1:n,3);

fft_x = fft(1:n,1);

dft_x = dft(1:d,1);

dft_par_y = (dft(1:d,3)./dft_par(1:d,3));
dft_fft = fft(1:d,3)./dft_par(1:d,3);

speed_up = semilogx(fft_x,fft_opt_y,fft_x,fft_tg_y,fft_x,fft_parfor_y,fft_x,fft_comb_y,dft_x,dft_par_y,dft_x, dft_fft);
xlabel('Transform Size (n)');
ylabel('Speed up compared to a base case');
title('A graph showing speed up compared to base cases of FFT and DFT using TBB. Computer: 2011 Macbook Air, OS: OS X 10.9, CPU: Intel Core i5 Dual Core HyperThreaded');
legend('Optmised FFT vs FFT','Task Based FFT vs FFT', 'Parallel For FFT vs FFT', 'Combined TaskBased FFT vs FFT', 'Parallel For DFT vs DFT', 'Parallel For DFT vs FFT');
print('-dpdf', 'tp709_speedup');

fft_opt_1 = csvread('fft_opt_1.csv',1,3);
fft_opt_2 = csvread('fft_opt_2.csv',1,3);
fft_opt_3 = csvread('fft_opt_3.csv',1,3);
fft_opt_4 = csvread('fft_opt_4.csv',1,3);

Pn = min(length(fft_opt_1),min(length(fft_opt_2),min(length(fft_opt_3),length(fft_opt_4))));
fft_opt_1_y = fft(1:Pn,3)./fft_opt_1(1:Pn,3);
fft_opt_2_y = fft(1:Pn,3)./fft_opt_2(1:Pn,3);
fft_opt_3_y = fft(1:Pn,3)./fft_opt_3(1:Pn,3);
fft_opt_4_y = fft(1:Pn,3)./fft_opt_4(1:Pn,3);
fft_opt_P_x = fft_opt_1(1:Pn,1);

scalability = semilogx(fft_opt_P_x,fft_opt_1_y,fft_opt_P_x,fft_opt_2_y,fft_opt_P_x,fft_opt_3_y,fft_opt_P_x,fft_opt_4_y);
xlabel('Transform Size (n)');
ylabel('Speed up compared to Single Thread FFT');
title('A graph showing speed up over. Computer: 2011 Macbook Air, OS: OS X 10.9, CPU: Intel Core i5 Dual Core HyperThreaded');
legend('1 Core', '2 Cores', '3 Cores', '4 Cores');
%print('-dpdf', 'tp709_speedup');

