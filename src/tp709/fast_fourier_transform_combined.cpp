#include "fourier_transform.hpp"

#include <cmath>
#include <cassert>
#include "tbb/parallel_for.h"
#include "tbb/task_group.h"

namespace hpce
{
	namespace tp709
	{
		class fast_fourier_transform_combined
			: public fourier_transform
		{
		protected:
			/* Standard radix-2 FFT only supports binary power lengths */
			virtual size_t calc_padded_size(size_t n) const
			{
				assert(n!=0);
				
				size_t ret=1;
				while(ret<n){
					ret<<=1;
				}
				
				return ret;
			}
		
			virtual void forwards_impl(
				size_t n,	const std::complex<double> &wn,
				const std::complex<double> *pIn, size_t sIn,
				std::complex<double> *pOut, size_t sOut
			) const 
			{
				assert(n>0);
				tbb::task_group fft_group;
				
				if (n == 1){
					pOut[0] = pIn[0];
				}else if (n == 2){
					pOut[0] = pIn[0]+pIn[sIn];
					pOut[sOut] = pIn[0]-pIn[sIn];
				}else{
					size_t m = n/2;
		
					fft_group.run( [=]{forwards_impl(m,wn*wn,pIn,2*sIn,pOut,sOut); } );
					fft_group.run( [=]{forwards_impl(m,wn*wn,pIn+sIn,2*sIn,pOut+sOut*m,sOut); } );
									 	
					fft_group.wait();
					
					size_t K = 8;
					while(K>m)
					{
						K=K/2;
						if(K<1)
						{
							K=1;
							break;
						}
					}			
										
					tbb::parallel_for(size_t(0), m/K, [=](size_t j0)
					{
						std::complex<double> w=/*std::complex<double>(1.0, 0.0)**/std::pow(wn,(double)j0*(double)K);
						
						for(size_t j1=0; j1<K;j1++)
						{
							size_t j = j0*K + j1;
					  		std::complex<double> t1 = w*pOut[m+j];
					  		std::complex<double> t2 = pOut[j]-t1;
					  		pOut[j] = pOut[j]+t1;                 /*  pOut[j] = pOut[j] + w^i pOut[m+j] */
					  		pOut[j+m] = t2;                          /*  pOut[j] = pOut[j] - w^i pOut[m+j] */
					  		w = w*wn;
						}
					});
				}
			}
			
			virtual void backwards_impl(
				size_t n,	const std::complex<double> &wn,
				const std::complex<double> *pIn, size_t sIn,
				std::complex<double> *pOut, size_t sOut
			) const 
			{
				complex_t reverse_wn=1.0/wn;
				forwards_impl(n, reverse_wn, pIn, sIn, pOut, sOut);
				
				double scale=1.0/n;
				for(size_t i=0;i<n;i++){
					pOut[i]=pOut[i]*scale;
				}
			}
			
		public:
			virtual std::string name() const
			{ return "hpce.tp709.fast_fourier_transform_combined"; }
			
			virtual bool is_quadratic() const
			{ return false; }
		};
		
		std::shared_ptr<fourier_transform> Create_fast_fourier_transform_combined()
		{
			return std::make_shared<fast_fourier_transform_combined>();
		}
	};
		
}; // namespace hpce
