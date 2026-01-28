
# Compiler settings - can be overridden via environment
MPICC   ?= mpicc
CC      ?= gcc
AR      = ar rc
RANLIB  = ranlib

FLAGS   = -c 
LDFLAGS = -fPIC -shared

# MPI paths - try to use compiler wrapper defaults, override if needed
MPI_LIB ?= 
MPI_INC ?= 

# PAPI paths - must be set via environment or passed to make
PAPI_INC ?= 
PAPI_LIB ?= 

# Build library flags
ifeq ($(MPI_LIB),)
  MPI_LIB_FLAGS = -lmpi
else
  MPI_LIB_FLAGS = -L$(MPI_LIB) -lmpi
endif

all:  vm.so

vm.so: vm.o vm.c 
	$(MPICC) -m64 -fPIC vm.o $(MPI_LIB_FLAGS) -L$(PAPI_LIB) -lpapi -shared -o vm.so 

vm.o: vm.h vm.c
	$(MPICC) -fPIC $(FLAGS)  vm.c -I$(MPI_INC) -I$(PAPI_INC)

clean: 
	rm -f *.o *.a *.so

