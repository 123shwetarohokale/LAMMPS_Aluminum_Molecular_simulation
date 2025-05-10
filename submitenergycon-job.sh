#!/bin/bash
#SBATCH -p shortgpu #gpu-p100, shortgpu, shortgpu-p100, short, bsudfq, 
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=14
#SBATCH --gres=gpu:1 #(number of GPUs requested) #HOOMD & LAMMPS peeps, Gromacs peeps remove
#SBATCH -t 30:00
#SBATCH -o al.o%j
#SBATCH -J Aluminum
# #SBATCH --exclusive

module load lammps_gpu
export OMP_NUM_THREADS=14
mpirun -np 1 -npernode 14 lmp -sf gpu -pk gpu 1 -in in_autocorrelation.nvt -var latconst 4
