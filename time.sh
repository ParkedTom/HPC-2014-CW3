#!/bin/bash

        ./bin/time_fourier_transform hpce.direct_fourier_transform 4 20| tee dft.csv

        ./bin/time_fourier_transform hpce.fast_fourier_transform 4 20 | tee fft.csv

        ./bin/time_fourier_transform hpce.tp709.direct_fourier_transform_parfor 4 20 | tee dft_par.csv

        ./bin/time_fourier_transform hpce.tp709.fast_fourier_transform_taskgroup 4 20 | tee fft_tg.csv

        ./bin/time_fourier_transform hpce.tp709.fast_fourier_transform_parfor 4 20 | tee fft_parfor.csv

        ./bin/time_fourier_transform hpce.tp709.fast_fourier_transform_combined 4 20 | tee fft_comb.csv

        ./bin/time_fourier_transform hpce.tp709.fast_fourier_transform_opt 4 20 | tee fft_opt.csv


for i in {1..4}
do
	#./bin/time_fourier_transform hpce.direct_fourier_transform $i 100 | tee dft_$i.csv
	
	#./bin/time_fourier_transform hpce.fast_fourier_transform $i 100 | tee fft_$i.csv
	
	#./bin/time_fourier_transform hpce.tp709.direct_fourier_transform_parfor $i 20 | tee dft_par_$i.csv
	#
	#./bin/time_fourier_transform hpce.tp709.fast_fourier_transform_taskgroup $i 20 | tee fft_tg_$i.csv
	#
	#./bin/time_fourier_transform hpce.tp709.fast_fourier_transform_parfor $i 20 | tee fft_parfor_$i.csv
	#
	#./bin/time_fourier_transform hpce.tp709.fast_fourier_transform_combined $i 20 | tee fft_comb_$i.csv
	
	./bin/time_fourier_transform hpce.tp709.fast_fourier_transform_opt $i 20 | tee fft_opt_$i.csv
done