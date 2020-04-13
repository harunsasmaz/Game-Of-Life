#!/bin/bash
#
# You should only work under the /scratch/users/<username> directory.
#
# Example job submission script
#
# -= Resources =-
#
#SBATCH --job-name=game-of-life-jobs
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=16
#SBATCH --partition=short
#SBATCH --time=00:30:00
#SBATCH --output=game-of-life.out
#SBATCH --exclusive

################################################################################
##################### !!! DO NOT EDIT ABOVE THIS LINE !!! ######################
################################################################################
# Set stack size to unlimited
echo "Setting stack size to unlimited..."
ulimit -s unlimited
ulimit -l unlimited
ulimit -a
echo

echo "Running Job...!"
echo "==============================================================================="
echo "Running compiled binary..."


#Strong scaling
echo "------------ STRONG SCALING TEST -------------"

echo "Serial version"
export KMP_AFFINITY=granularity=fine,compact
./life-srl -n 2000 -i 500 -p 0.2 -d 

echo "Parallel version with 1 thread"
export KMP_AFFINITY=granularity=fine,compact
./life -n 2000 -i 500 -p 0.2 -d -t 1

echo "Parallel version with 2 threads"
export KMP_AFFINITY=granularity=fine,compact
./life -n 2000 -i 500 -p 0.2 -d -t 2

echo "Parallel version with 4 threads"
export KMP_AFFINITY=granularity=fine,compact
./life -n 2000 -i 500 -p 0.2 -d -t 4

echo "Parallel version with 8 threads"
export KMP_AFFINITY=granularity=fine,compact
./life -n 2000 -i 500 -p 0.2 -d -t 8

echo "Parallel version with 16 threads"
export KMP_AFFINITY=granularity=fine,compact
./life -n 2000 -i 500 -p 0.2 -d -t 16

echo "Parallel version with 32 threads"
export KMP_AFFINITY=granularity=fine,compact
./life -n 2000 -i 500 -p 0.2 -d -t 32

#Input size test
echo "--------------- INPUT SIZE TEST -------------------"

echo "Parallel version with 2000"
export KMP_AFFINITY=granularity=fine,compact
./life -n 2000 -i 500 -p 0.2 -d -t 16

echo "Parallel version with 4000"
export KMP_AFFINITY=granularity=fine,compact
./life -n 4000 -i 500 -p 0.2 -d -t 16

echo "Parallel version with 6000"
export KMP_AFFINITY=granularity=fine,compact
./life -n 6000 -i 500 -p 0.2 -d -t 16

echo "Parallel version with 8000"
export KMP_AFFINITY=granularity=fine,compact
./life -n 8000 -i 500 -p 0.2 -d -t 16

echo "Parallel version with 10000"
export KMP_AFFINITY=granularity=fine,compact
./life -n 10000 -i 500 -p 0.2 -d -t 16

echo "------------------------- end of tests --------------"

lscpu
