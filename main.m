% Do not change this script. 

clear all
rng('shuffle')

%% Set variables

% Setup % Do stuff that is more permanent (compiling models, creating folders etc)
clear all
restoredefaultpath

%% Run optimizations
%  
    seed=randi([0,32767],1);
    EstimateParameters(seed) % you can add more input if you want, but do not remove seed. 
% end


