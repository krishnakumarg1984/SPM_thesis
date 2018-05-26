% Copyright (c) 2018 Gopalakrishnan, Krishnakumar <krishnak@vt.edu>
% Author: Gopalakrishnan, Krishnakumar <krishnak@vt.edu>

clear;clc; format short g; format compact; close all;
addpath(genpath('../spm_results'));
load('cts_sim_May_26_2018_20_35_34');

run('plots_spm.m');
clear;

load('disc_sim_May_26_2018_20_36_07');
figure(1); subplot(211); hold on; subplot(212); hold on;
figure(2); subplot(211); hold on; subplot(212); hold on;

run('plots_spm.m');

figure(1);
shg;