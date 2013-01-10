%TCL model params

%influx rate of target cells
param.s = 100;

%target cell loss rate
param.d = 0.01;

%target cell infection rate constant
param.beta = 1.3e-6;

%infected cell loss rate
param.delta = 0.5;

%virus production rate
param.p = 1000;

%virus clearance rate 
param.c = 3;

%_________________________________________________________________________

%Extended model params

%how cytopathic is the virus? alpha>1 => virus kills cells above and beyond
%normal death rate 
param.alpha = 1;

%half maximal effector cell stimulation threshhold 
param.theta = 3;

%depletion rate of infected cells by immune efector cells
%UNKNOWN
param.k0 = 0.2;

%rate of production of effector cells
param.a_E = 5;
%UNKNOWN

%rate of loss of effector cells
param.d_E = 1;
%UNKNOWN

%__________________________________________________________________________

%Quasi steady state extended model params

param.k = 1; %param.k0*param.a_E/param.d_E = 1;

param.betadash = param.beta*param.p/param.c;
