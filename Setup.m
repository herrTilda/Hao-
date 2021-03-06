function []=Setup()
%% Add IQM or other toolboxes NECESSARY FOR COMPILATION ONLY

run('../MATLAB/IQMtools/installIQMtoolsInitial.m')
addpath('./Models')
addpath('./data')
addpath('../MATLAB')

%% Create necessary folders and compile models
if ~exist('Log','dir') % You "need" to have a log folder 
    mkdir('Log')
end

%% Compile stuff
cd Models
models=dir('*.txt');

for i =1:length(models)
    IQMmakeMEXmodel(IQMmodel(models(i).name))
    mkdir( strrep(['../Results/' models(i).name  '/' datestr(now,'yymmdd-HHMMSS')], '.txt',''))
end
cd ..

end
