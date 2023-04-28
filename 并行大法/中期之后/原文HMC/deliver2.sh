#!/bin/bash
#SBATCH --partition=C032M0128G
#SBATCH --qos=high
#SBATCH -J Mb_0.01K
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=10
#SBATCH --time=24:00:00

module load matlab/R2022a
matlab -nodesktop -nosplash -nodisplay -r HMC2
