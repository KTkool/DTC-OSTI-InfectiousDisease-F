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

function [ m ] = derivativesEMProteasetreatment( t,y, param )
<<<<<<< HEAD
%Calculates the derivatives for each equation in the extended model with protease treatment
=======
%Calculates the derivatives for each equation in the extended model with quasi 
%steady state approximation. 
%In the model cells are sujected to  protease (PI) treatment. Protease treatment results in the
%production of infectious virus particles (VI) and non-infectious virus
%particles (VNI).
%To put themodel into a suitable form for MATLAB, each variable has been
%listed as a component in the solution vector y as follows:
%
% T = y(1) = Concentration of target cells
% I = y(2) = Concentration of infected cells
% VI = y(3) = Serum virus concentration (infectious)
% VNI = y(3) = Serum virus concentration (non-infectious)
% E = y(4) = Concentration of immune effector cells
>>>>>>> combined therapy, descriptions

m = zeros(5,1);

m(1) = param.s-param.d*y(1)-param.beta*y(1)*y(3);

m(2) = param.beta*y(1)*y(3)-(param.alpha*param.d + param.k0*y(4))*y(2);

m(3) = (1- param.PI)*param.p*y(2)-param.c*y(3);

m(4) = param.PI*param.p*y(2)-param.c*y(4);

m(5) = param.a_E*y(2)/(param.theta+y(2))-param.d_E*y(5);



end
