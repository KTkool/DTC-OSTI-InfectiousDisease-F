%Target Cell Limited model params

%influx rate of target cells, cells/mL/day
param.s = 100;

%target cell loss rate, /day
param.d = 0.01;

%target cell infection rate constant, ml/RNA/day
param.beta = 1.3e-6;

%infected cell loss rate, /day 
param.delta = 0.5;

%virus production rate
param.p = 1000;

%virus clearance rate, /day
param.c = 3;

%______________________________________________________________________%

%Extra parameters for model with treatment 

%CD4+ cell production rate per day
%param.p = 0.03;


%Effectiveness of reverse transciptase inhibiton
param.RTT = 1.0;
% !!! THIS WE NEED TO REMOVE FOR OUR MODEL!!! AKM
% !!! LATER OVERWRITTEN WITH 0.8!!! AKM

%time of treatment start
param.t_st = 50;
% !!! LATER OVERWRITTEN WITH 75!!! AKM

param.PI = 0.9;
% !!!LATER OVERWRITTEN WITH 0.8!!!

%Extended model params

%how cytopathic is the virus? alpha>1 => virus kills cells above and beyond
%normal death rate. No units. 
param.alpha = 1;

%half maximal effector cell stimulation threshhold cells/ml
param.theta = 3;

%depletion rate of infected cells by immune effector cells /day
%UNKNOWN
param.k0 = 0.2;

%rate of production of effector cells /day
param.a_E = 5;
%UNKNOWN

%rate of loss of effector cells /day
param.d_E = 1;
%UNKNOWN

%__________________________________________________________________________

%Quasi steady state extended model params

%Composite parameter including k0, a_E and d_E. /day
param.k = 1; %param.k0*param.a_E/param.d_E

%__________________________________________________________________________

%Useful parameter combination for determining stability of steady states
param.betadash = param.beta*param.p/param.c;

%__________________________________________________________________________

%Effectiveness of reverse transciptase inhibition
param.RTT = 0.8;

%time of treatment start
param.t_st = 75;

%Effectiveness of protease inhibiton
param.PI = 0.8;

%death rate of CD4 cells due to treatment 
param.dr = 0.0;

%__________________________________________________________________________

% parameters for the resistance functions
param.fOn  = @(t,y,p) resistanceRTTLogistic(t,y,p,0.02);
param.fOff = @(t,y,p) resistanceRTTLogistic(t,y,p,-0.001);
param.gOn  = @(t,y,p) resistancePILogistic(t,y,p,0.03);
param.gOff = @(t,y,p) resistancePILogistic(t,y,p,-0.002);