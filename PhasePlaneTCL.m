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

function [] = PhasePlaneTCL(m,n);
%PHASE PLOTS: Phase plotting the TCM model. m, n are input parameters
%corresponding to 1 = T, 2 = I, 3 = V.

if(m > 3 || n > 3 || m <= 0 || n <= 0)
    disp('Enter values between 0 and 3');
    return;
end

%solve the TCL condition
params;
[t, y] = ode45(@(t,y)derivativesTCL(t, y, param), [0, 250], [10000, 0, 1e-6]);


plot(y(:,m), y(:,n));
xlabel(m);
ylabel(n);
end
