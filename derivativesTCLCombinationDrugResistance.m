%{
Copyright 2013 Ronja Woloszczuk

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

function [ dy ] = derivativesTCLCombinationDrugResistance( t, y, param, f, g )
%Calculates the derivatives for each equation in the target cell limited model with Drug Resistance.
%In the model cells are sujected to a combination of protease (PI) and reverse
%transcriptase treatment (RTT). Protease treatment results in the
%production of infectious virus particles (VI) and non-infectious virus
%particles (VNI).CD4D means that CD4 cells will die at a certain rate (dr) due to the drug
% treatment
%To put the model into a suitable form for MATLAB, each variable has been
%listed as a component in the solution vector y as follows:
%
% T = y(1) = Concentration of target cells
% I = y(2) = Concentration of infected cells
% VI = y(3) = Serum virus concentration (infectious)
% f = y(4) = dRTT/dt
% g = y(5) = dPI/dt

dy = zeros(5,1);
dy(1) = param.s - (param.dr + param.d) * y(1) - (1-y(4)) * param.beta * y(1) * y(3);
dy(2) = (1-y(4)) * param.beta * y(1) * y(3) - (param.dr + param.delta) * y(2);
dy(3) = (1 - y(5)) * param.p * y(2) - param.c * y(3);
%dy(3) = (1 - y(5)) * param.delta * param.p * y(2) - param.c * y(3);
% PARAM.DELTA MIGHT BE WRONG HERE
dy(4) = f(t, y, param);  
dy(5) = g(t, y, param);

end
