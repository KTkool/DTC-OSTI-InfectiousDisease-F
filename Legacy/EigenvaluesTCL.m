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


function [R_0, eigVal] = EigenvaluesTCL(param)
%CALCULATES STABILITY PARAMETER R_0 AND EIGENVALUES OF INFECTIVE STATE IN
%TCL MODEL
%Takes in the param struct, and outputs scalar R_0 and both eigenvalues
%associated with infective steady state in vector 2x1

%Stability analysis is performed as in Appendix A (page 757)
%Find the steady state values of T and I for approximated TCL model
%analytically (equation 11), i.e. when 
    %dT/dt = s - (d + beta'I)T = 0
    %dI/dt = (beta'T-delta)I = 0

    %Obtain two steady states, S1 = healthy (infection free)
    %                          S2 = infected
    
%clear from equations above that infected state only apparent if
%beta's/delta > 1, call this R_0

%Define beta'
param.betadash = (param.beta * param.p)/ param.c;
%Define R_0
R_0 = param.betadash*param.s/(param.d*param.delta);

%if statement to avoid dividing by 0 errors
if( param.c ~= 0)
    %Jacobian of infected steady state matrix
    Jacobian = [-param.betadash*param.s/param.delta, -param.delta; ...
            -param.betadash*param.s/param.delta - param.d, 0];
    %calculate eigenvalues for this jacobian
    [~, eigValues] = eig(Jacobian);
    %output values in a 2x1 vector
    eigVal(1) = eigValues(1,1);
    eigVal(2) = eigValues(2,2);
else
    %if c = 0, then just let the eigenvalues = 0
    eigVal = zeros(2,1);

end

    
    
        

