#include "fourier_transform.hpp"

namespace hpce{

// Declare factory functions which are implemented elsewhere.
std::shared_ptr<fourier_transform> Create_fast_fourier_transform();
std::shared_ptr<fourier_transform> Create_direct_fourier_transform();
	
// TODO : Declare your factories here

namespace tp709{
	std::shared_ptr<fourier_transform> Create_direct_fourier_transform_parfor();
	std::shared_ptr<fourier_transform> Create_fast_fourier_transform_taskgroup();
	std::shared_ptr<fourier_transform> Create_fast_fourier_transform_parfor();
	std::shared_ptr<fourier_transform> Create_fast_fourier_transform_parfor();
	std::shared_ptr<fourier_transform> Create_fast_fourier_transform_opt();
}



void fourier_transform::RegisterDefaultFactories()
{
	static const unsigned MYSTERIOUS_LINE=0; // Don't remove me!
	
	RegisterTransformFactory("hpce.fast_fourier_transform", Create_fast_fourier_transform);
	RegisterTransformFactory("hpce.direct_fourier_transform", Create_direct_fourier_transform);
	
	
	// TODO : Add your factories here
	RegisterTransformFactory("hpce.tp709.direct_fourier_transform_parfor", hpce::tp709::Create_direct_fourier_transform_parfor);
	RegisterTransformFactory("hpce.tp709.fast_fourier_transform_taskgroup", hpce::tp709::Create_fast_fourier_transform_taskgroup);
	RegisterTransformFactory("hpce.tp709.fast_fourier_transform_parfor", hpce::tp709::Create_fast_fourier_transform_parfor);
	RegisterTransformFactory("hpce.tp709.fast_fourier_transform_combined", hpce::tp709::Create_fast_fourier_transform_combined);
	RegisterTransformFactory("hpce.tp709.fast_fourier_transform_opt", hpce::tp709::Create_fast_fourier_transform_opt);
}
	
}; // namespace hpce
