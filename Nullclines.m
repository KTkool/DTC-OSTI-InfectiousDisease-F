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

%PLOTS The nullclines in FIG. 3 for Extended Simplified Model;
%   I = 0;
%   I_1 = (s-dT)/beta'T
%   I_2 = theta*(beta'T - k)/(k +alpha*d - beta'T)


clear
params;
%Calculates value at which I_3 asymtotes to infinity to plot around
%this point P.
P = (param.k + param.alpha*param.d)/param.betadash;
P2 = floor(P*5.1);

T = -3000:0.5:P2;


I_1 = 0;

I_2 = (param.s - param.d .* T)./(param.betadash .* T);

I_3 = param.theta .* (param.betadash.*T - param.k)./(param.k + param.alpha.*param.d - param.betadash.*T);


plot(T, I_1, 'k', T, I_2, 'b', T, I_3, 'g');
ylabel('I');
xlabel('T');
legend('I=0', 'I_2', 'I_3');
ylim([-125 125]);

