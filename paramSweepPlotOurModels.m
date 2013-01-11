%Script that runs a parameter sweep and plots effect on final virus titer
%for 3 models - Target Cell Limited, Extended and Extended Simplified

%paramSweepPlot goes through varies all parameters in the struct, not only the ones  
params;
param=rmfield(param,{'alpha','theta','k0','a_E','d_E','k','betadash'});
f1=figure;
set(f1,'name','Target Cell Limited Model - effect of parameters on final virus titer','numbertitle','off')
paramSweepPlot(param,@derivativesTCL,[10000,0,1e-6],@extractSolProperties,10)

params;
param=rmfield(param,{'k','delta','betadash'});
f2=figure;
set(f2,'name','Extended Model - effect of parameters on final virus titer','numbertitle','off')
paramSweepPlot(param,@derivativesEM,[10000,0,1e-6,100],@extractSolProperties,10)

params;
param=rmfield(param,{'k0','delta','a_E','d_E'});
f3=figure;
set(f3,'name','Extended Simplified Model - effect of parameters on final virus titer','numbertitle','off')
paramSweepPlot(param,@derivativesEMS,[10000,0,1e-6],@extractSolProperties,10)