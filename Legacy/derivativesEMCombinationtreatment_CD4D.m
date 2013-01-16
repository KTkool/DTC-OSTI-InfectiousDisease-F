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

function [ m ] = derivativesEMCombinationtreatment_CD4D( t,y, param )
%Calculates the derivatives for each equation in the extended model with quasi 
%steady state approximation.
%In the model cells are sujected to a combination of protease (PI) and reverse
%transcriptase treatment (RTT). Protease treatment results in the
%production of infectious virus particles (VI) and non-infectious virus
%particles (VNI).CD4D means that CD4 cells will die at a certain rate (dr) due to the drug
% treatment
%To put themodel into a suitable form for MATLAB, each variable has been
%listed as a component in the solution vector y as follows:
%
% T = y(1) = Concentration of target cells
% I = y(2) = Concentration of infected cells
% VI = y(3) = Serum virus concentration (infectious)
% VNI = y(4) = Serum virus concentration (non-infectious)
% E = y(5) = Concentration of immune effector cells

m = zeros(5,1);

m(1) = param.s-(param.dr + param.d)*y(1)-(1-param.RTT)*param.beta*y(1)*y(3);

m(2) = (1-param.RTT)*param.beta*y(1)*y(3)-(param.dr + param.alpha*param.d + param.k0*y(4))*y(2);

m(3) = (1- param.PI)*param.alpha*param.d*param.p*y(2)-param.c*y(3);
% !!! WOAW WHAT ALL ALL THESE PARAMETERS DOING THERE???? AKM

m(4) = param.PI* param.alpha *param.d *param.p*y(2)-param.c*y(4);
% !!! SAME HERE!!!

m(5) = param.a_E*y(2)/(param.theta+y(2))-param.d_E*y(5);

end

% ??? WHAT DO WE TRUST? THE CODE THE REPORT OR OUR INSTINCT???
