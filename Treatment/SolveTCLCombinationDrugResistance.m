%{
Copyright 2013 A-team

This file is part of DTC-OSTI-group-A.

DTC-OSTI-group-A is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

DTC-OSTI-group-A is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with DTC-OSTI-group-A. If not, see <http://www.gnu.org/licenses/>.
%}

function [t,y] = SolveTCLCombinationDrugResistance( param, resolutionDomain, initialConditions, drug1On, drug2On )
% solve the system taking into account which drugs are used
% drug1on = 1 means that drug1 is being used

tol = 0.05;

f = [];
g = [];
if ((drug1On < tol) && (drug2On < tol))
   f = param.fOff;
   g = param.gOff;
elseif ((drug1On >= tol) && (drug2On < tol))
    f = param.fOn;
    g = param.gOff;
elseif ((drug1On < tol) && (drug2On >= tol))
    f = param.fOff;
    g = param.gOn;
else
    f = param.fOn;
    g = param.gOn;
end;

derivatives = @(t,y) derivativesTCLCombinationDrugResistance(t,y,param,f,g,drug1On,drug2On);
[t,y] = ode15s(derivatives, [0 resolutionDomain], initialConditions);

end