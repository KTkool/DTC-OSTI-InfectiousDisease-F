%{
Copyright 2013 Kathryn Atwell
	
This file is part of DTC-OSTI-InfectiousDisease-F.

DTC-OSTI-InfectiousDisease-F is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

DTC-OSTI-InfectiousDisease-F is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with DTC-OSTI-InfectiousDisease-F. If not, see <http://www.gnu.org/licenses/>.
%}



%Script that runs a parameter sweep and plots effect on final virus titer
%and final target cell count.
%Runs for 3 models - Target Cell Limited, Extended and Extended Simplified

%paramSweepPlot goes through varies all parameters in the struct, not only the ones
%used in the model. So need to ensure struct only contains required
%parameters

params;
param=rmfield(param,{'alpha','theta','k0','a_E','d_E','k','betadash','dr','RTT','t_st','PI'});
f1=figure;
set(f1,'name','Target Cell Limited Model - effect of parameters on final virus titer','numbertitle','off')
paramSweepPlot(param,@derivativesTCL,[10000,0,1e-6],@extractFinalVirus,10)

fprintf('\n');

params;
param=rmfield(param,{'k','delta','betadash','dr','RTT','t_st','PI'});
f2=figure;
set(f2,'name','Extended Model - effect of parameters on final virus titer','numbertitle','off')
paramSweepPlot(param,@derivativesEM,[10000,0,1e-6,100],@extractFinalVirus,10)

fprintf('\n');

params;
param=rmfield(param,{'k0','delta','a_E','d_E','betadash','dr','RTT','t_st','PI'});
f3=figure;
set(f3,'name','Extended Simplified Model - effect of parameters on final virus titer','numbertitle','off')
paramSweepPlot(param,@derivativesEMS,[10000,0,1e-6],@extractFinalVirus,10)

fprintf('\n');
fprintf('\n');

params;
param=rmfield(param,{'alpha','theta','k0','a_E','d_E','k','betadash','dr','RTT','t_st','PI'});
f4=figure;
set(f4,'name','Target Cell Limited Model - effect of parameters on final target cell count','numbertitle','off')
paramSweepPlot(param,@derivativesTCL,[10000,0,1e-6],@extractFinalTarget,10)

fprintf('\n');

params;
param=rmfield(param,{'k','delta','betadash','dr','RTT','t_st','PI'});
f5=figure;
set(f5,'name','Extended Model - effect of parameters on final target cell count','numbertitle','off')
paramSweepPlot(param,@derivativesEM,[10000,0,1e-6,100],@extractFinalTarget,10)

fprintf('\n');

params;
param=rmfield(param,{'k0','delta','a_E','d_E','betadash','dr','RTT','t_st','PI'});
f6=figure;
set(f6,'name','Extended Simplified Model - effect of parameters on final target cell count','numbertitle','off')
paramSweepPlot(param,@derivativesEMS,[10000,0,1e-6],@extractFinalTarget,10);
