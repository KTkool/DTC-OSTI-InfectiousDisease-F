%{
Copyright 2013 Adam Berrington
	
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

%STABILITY ANALYSIS: Calculates the stability criteria value R_0 for the
%TCL system and also outputs Eigenvalues of Infected steady state.
function [R_0, eigVal] = EigenvaluesTCL(param);
param.betadash = (param.beta * param.p)/ param.c;

R_0 = param.betadash*param.s/(param.d*param.delta);

Jacobian = [-param.betadash*param.s/param.delta, -param.delta; ...
            -param.betadash*param.s/param.delta - param.d, 0];
        
[eigVec, eigVal] = eig(Jacobian);

end

    
    
        

