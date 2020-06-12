local_repository  = 'C:/Users/Mahe/Desktop/PancreaticDATA/';
pcancerFiles = dir([local_repository 'Cancer/*.txt']);
pnormalFiles = dir([local_repository 'Normal/*.txt']);
files = [ strcat('Cancer/',{pcancerFiles.name}) ...
          strcat('Normal/',{pnormalFiles.name})];
N = numel(files)   % total number of files
tic
repository = local_repository;
K = N; % change to N to do all

[PanMZ,PanY] = msbatchprocessing(repository,files(1:K));

disp(sprintf('Sequential time for %d spectrograms: %f seconds',K,toc))

PanY = msnorm(PanMZ,PanY,'QUANTILE',0.5,'LIMITS',[3500 11000],'MAX',50);
Pangrp = [repmat({'PanDef'},size(pcancerFiles));...
       repmat({'NormalDef'},size(pnormalFiles))];
PanIdx = find(strcmp(Pangrp,'PanDef'));
numel(PanIdx) % number of files in the "Cancer" subdirectory
normalIdx = find(strcmp(Pangrp,'NormalDef'));
numel(normalIdx) % number of files in the "Normal" subdirectory
h = plot(PanMZ,PanY(:,PanIdx(1:5)),'b',PanMZ,PanY(:,normalIdx(1:5)),'r');
axis([7650 8200 -2 50])
xlabel('Mass/Charge (M/Z)');ylabel('Relative Intensity')
legend(h([1 end]),{'PancreaticDefinite','Control'})
title('Region of the pre-processed spectrograms')
save PacnoQAQCdataset.mat PanY PanMZ Pangrp