module purge
module load containers/singularity/3.9.9
singularity pull cmdstanr.sif docker://ghcr.io/jbris/stan-cmdstanr-docker:latest
