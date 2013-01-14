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

function [ dy ] = derivativesEMSProteasetreatment( t, y, param )
%Calculates the derivatives for each equation in the target cell limited model. 
%To put themodel into a suitable form for MATLAB, each variable has been
%listed as a component in the solution vector y as follows:
%
% T = y(1) = Concentration of target cells
% I = y(2) = Concentration of infected cells
% V = y(3) = Serum virus concentration


dy=zeros(4,1);
dy(1) = param.s-param.d*y(1)-param.beta*y(1)*y(3);
dy(2) = param.beta*y(1)*y(3)- (param.alpha*param.d + param.k0 * y(2)/(y(2)+param.theta)) *y(2);
dy(3) = (1 - param.PI)*param.p*y(2)-param.c*y(3);
dy(4) = param.PI *param.p*y(2)-param.c*y(4);


end
