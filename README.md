# MPI Wrapping for Profiling
This library wraps MPI calls to collect PAPI performance counters.
 
make vm.so
## Building

### Quick Start
```bash
# Default build (uses mpicc and auto-detects paths)
make

# Or source machine-specific environment first
source mn5.env && make
# or
source levante.env && make
```

### Configuration

The Makefile supports environment variables for flexibility:

- `MPICC`: MPI C compiler wrapper (default: `mpicc`)
- `CC`: C compiler (default: `gcc`)
- `MPI_LIB`: MPI library path (auto-detected if empty)
- `MPI_INC`: MPI include path (auto-detected if empty)
- `PAPI_LIB`: PAPI library path (optional if in system paths)
- `PAPI_INC`: PAPI include path (optional if in system paths)

### Machine-Specific Examples

**MareNostrum 5:**
```bash
source mn5.env
make
```

**Levante:**
```bash
# Load required modules first
module purge
module add intel-oneapi-compilers/2022.0.1-gcc-11.2.0
module add intel-oneapi-mpi/2021.5.0-intel-2021.5.0

source levante.env
make
```

**Custom/Other Systems:**
```bash
# Override variables as needed
make MPICC=mpiicc PAPI_INC=/custom/papi/include PAPI_LIB=/custom/papi/lib
```


# Usage:

#Set PAPI_LIST environment variable:
#List of papi counters to trace, comma-separated and without spaces. 

#(Ensure first that combination is permitted)

#If none are specified, PAPI_TOT_INS and PAPI_L3_TCM are set

export PAPI_LIST="PAPI_TOT_INS,PAPI_L3_TCM"

# Shared library preload
export LD_PRELOAD=$PATH_TO_THE_LIBRARY/vm.so

# Execute the MPI program as usual:

mpirun -np 4 program
