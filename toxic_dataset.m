function [x,t] = toxic_dataset


load ToxicoQAQCdataset.mat 
ind = rankfeatures(toxY,toxgrp,'Criterion','ttest','NumberOfIndices',100);
x = toxY(ind,:);
t = double(strcmp('Toxic',toxgrp));
t = [t; 1-t];