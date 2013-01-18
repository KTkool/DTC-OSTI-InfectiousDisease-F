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

function fval = resistanceRTTLogistic( t, y, param, k)
% gives the resistance against the drug
% yes, it actually does!, to code up drug effectiveness we need
% param.RTT-the value obtained from solving this differential equation.
% I can give you closed form for these equations, but that will be a bit of
% a pain to implement with initial conditions. AKM

%fval = k;
% logistic for RTT---Sorry same function for both is not possible
fval = k*y(4)*(1-y(4)/param.RTT);

end
