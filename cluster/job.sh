#!/bin/bash
#SBATCH --time=00:30:00
#SBATCH -J cmdstanr
#SBATCH -o cmdstanr.%N.%j.out
#SBATCH -e cmdstanr.%N.%j.err
#SBATCH --mem=5G
#SBATCH --cpus-per-task=4

module purge
module load containers/singularity/3.9.9
singularity exec cmdstanr.sif  Rscript script.R

