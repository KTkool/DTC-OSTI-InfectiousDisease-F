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


function [ y ] = SolveAndPlot()
% Solves ODEs of models one and two using ODE45
%   

clear;
params;


[t,y]=ode45(@derivativesTCL, [0 250], [1e4 0 1e-6], [], param);

subplot(3,2,1);
plot(t,y(:,1), 'r', t, y(:,2), 'g' );
xlabel('time(days)')
ylabel('cell count/ml')
title('Simple Model')
legend('targets', 'infected') 

subplot(3,2,2); 
semilogy(t, y(:,3), 'k');
xlabel('time(days)')
ylabel('virus titer')

[t,y]=ode45(@derivativesEM, [0 250], [1e4, 0, 1e-6 ,100], [], param);

subplot(3,2,3);
plot(t,y(:,1), 'r', t, y(:,2), 'g');
xlabel('time(days)')
ylabel('cell count/ml')
title('Extended Model including Effector Cells')
legend('targets', 'infected') 

subplot(3,2,4); 
semilogy(t, y(:,3), 'k');
xlabel('time(days)')
ylabel('virus titer')

[t,y]=ode45(@derivativesEMS, [0 250], [1e4, 0, 1e-6 ], [], param);

subplot(3,2,5);
plot(t,y(:,1), 'r', t, y(:,2), 'g');
xlabel('time(days)')
ylabel('cell count/ml')
title('Extended Simplified Model')
legend('targets', 'infected') 

subplot(3,2,6); 
semilogy(t, y(:,3), 'k');
xlabel('time(days)')
ylabel('virus titer')

end


