# Makefile for posix and gcc

# Note on old compilers  *cough*  DoC  *cough* you might need -std=c++0x instead
CPPFLAGS = -I include -Wall -std=c++11
LDFLAGS =
LDLIBS = -lm -ltbb

# Turn on optimisations
CPPFLAGS += -O2

# TODO : Indicate where you have put the TBB installer
TBB_DIR = ~/tbb42_20140122oss

TBB_INC_DIR = $(TBB_DIR)/include

#DYLD_LIBRARY_PATH = $(TBB_LIB_DIR)

# TODO: Choose the correct library for your build
TBB_LIB_DIR = $(TBB_DIR)/lib

CPPFLAGS += -I $(TBB_INC_DIR)
LDFLAGS += -L $(TBB_LIB_DIR)

# The very basic parts
FOURIER_CORE_OBJS = src/fourier_transform.o src/fourier_transform_register_factories.o

# implementations
FOURIER_IMPLEMENTATION_OBJS =  src/fast_fourier_transform.o	src/direct_fourier_transform.o	src/tp709/direct_fourier_transform_parfor.o src/tp709/fast_fourier_transform_taskgroup.o src/tp709/fast_fourier_transform_parfor.o src/tp709/fast_fourier_transform_combined.o

FOURIER_OBJS = $(FOURIER_CORE_OBJS) $(FOURIER_IMPLEMENTATION_OBJS)

bin/test_fourier_transform : src/test_fourier_transform.cpp $(FOURIER_OBJS)
	-mkdir bin
	$(CXX) $(CPPFLAGS) $^ -o $@ $(LDFLAGS) $(LDLIBS)

bin/time_fourier_transform : src/time_fourier_transform.cpp $(FOURIER_OBJS)
	-mkdir bin
	$(CXX) $(CPPFLAGS) $^ -o $@ $(LDFLAGS) $(LDLIBS)

all : bin/test_fourier_transform bin/time_fourier_transform
