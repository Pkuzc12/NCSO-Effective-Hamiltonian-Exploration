JobPath = '/gpfs/share/home/2000012425/TN';    % Please update your folder directory
cd(JobPath);

%% Import Cluster Profile
allName = parallel.clusterProfiles();
if ~ismember('Weiming1_HPC_MATLAB',allName)
parallel.importProfile([JobPath,'/Weiming1_HPC_MATLAB']);  
end

%% Culster Settings
c = parcluster('Weiming1_HPC_MATLAB');      
c.ClusterMatlabRoot = '/gpfs/share/soft/MATLAB/R2019a';  % Change MATLAB version if needed"
c.AdditionalProperties.JobName = 'TN';
c.AdditionalProperties.JobPriority = 'low';
c.AdditionalProperties.Mail = '***@163.com';
c.AdditionalProperties.Partition = 'C032M0128G';
c.AdditionalProperties.NodeNum = '8';
c.AdditionalProperties.WorkerPerNode = '32'; 
c.AdditionalProperties.WallTime = '24:00:00';

j = batch(c,'main_multispin','Pool',255)    % Run a job for 63 works which is (64-1)
exit                                        


