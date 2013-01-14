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

%STABILITY ANALYSIS: Calculating steady states of QS Model
%APPENDIX B on paper
clear
params;

%Define a parameter sigma
%       when less than 1 - no infective steady state
%       when greather than 1 - infective steady state exists

sigma = param.betadash * param.s / (param.alpha * param.d^2);

sigma

%If the steady state exists then carry on, else quit this function
if(sigma > 1)
    disp('Greater than 1: Infective steady state exists');
else
    disp('Less than 1: Infective steady state does not exist');
end

[t, y] = ode45(@(t,y)derivativesQS(t, y, param), [0, 250], [1000, 0, 1e-6]);

I = y(:,2);
%Defining terms A, B, C in the infected steady state APPENDIX B

A = param.betadash*(param.k + param.alpha* param.d);

B = param.alpha*(param.d^2) - param.betadash*param.s + ...
    param.alpha*param.delta*param.betadash*param.theta + param.k*param.d;

C = param.theta*(param.alpha*(param.d^2) - param.betadash*param.s);

SteadyStateFunction = A*(I.*I) + B*I + C;


plot(I, SteadyStateFunction);
