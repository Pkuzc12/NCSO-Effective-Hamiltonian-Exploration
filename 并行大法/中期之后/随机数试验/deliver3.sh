#!/bin/bash
#SBATCH --partition=C032M0128G
#SBATCH --qos=high
#SBATCH -J rand3
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=16
#SBATCH --time=24:00:00

module load matlab/R2022a
matlab -nodesktop -nosplash -nodisplay -r r3
