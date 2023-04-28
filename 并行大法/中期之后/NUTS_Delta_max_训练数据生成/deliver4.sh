#!/bin/bash
#SBATCH -o job.%j.%N.out
#SBATCH --partition=C032M0128G
#SBATCH --qos=high
#SBATCH -J prepare
#SBATCH --get-user-env
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mail-type=end
#SBATCH --time=24:00:00

module load matlab/R2019a
matlab -nodesktop -nosplash -nodisplay -r Submit4 -log LogFile.txt
