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

function [ y ] = SolveAndPlotRTtreatment_CD4D()
% Solves ODEs of models one and two using ODE45
%   

clear;
params;

%RTT=0.5;

[t,y]=ode45(@derivativesTCL, [0 param.t_st], [1e4, 0, 1e-6 ], [], param);
T0RT= y(end,1);

I0RT = y(end,2); 

V0RT = y(end,3);
[t,y]=ode45(@derivativesTCL, [0 250], [1e4, 0, 1e-6 ], [], param);
[t1,m]=ode45(@derivativesTCLRTtreatment, [param.t_st 250], [T0RT I0RT V0RT], [], param);
[t1,m1]=ode45(@derivativesTCLRTtreatment_CD4D, [param.t_st 250], [T0RT I0RT V0RT], [], param);
subplot(3,2,1);
plot(t,y(:,1), 'b', t, y(:,2), 'k', t1,m(:,1), 'r', t1, m(:,2), 'g',  t1,m1(:,1), '--r', t1, m1(:,2), '--g'); 
xlabel('time(days)')
ylabel('cell count/ml')
title('Simple Model with RT Treatment')
legend('targets', 'infected', 'targets - RTT', 'infected - RTT', 'targets - RTT, CD4D ', 'infected - RTT, CD4D') 

subplot(3,2,2); 
semilogy(t, y(:,3), 'k', t1, m(:,3), 'b' , t1, m1(:,3), 'r'); 
xlabel('time(days)')
ylabel('virus titer/ ml')
legend('no RTT', 'RTT', 'RTT, CD4D')

[t,y]=ode45(@derivativesEM, [0 param.t_st], [1e4, 0, 1e-6 ,10], [], param);
T0RT= y(end,1);

I0RT = y(end,2); 

V0RT = y(end,3);

E0RT = y(end,4);
[t,y]=ode45(@derivativesEM, [0 250], [1e4, 0, 1e-6 ,10], [], param);
[t1,m]=ode45(@derivativesEMRTtreatment, [param.t_st 250], [T0RT I0RT V0RT E0RT], [], param);
[t2,m1]=ode45(@derivativesEMRTtreatment_CD4D, [param.t_st 250], [T0RT I0RT V0RT E0RT], [], param);
subplot(3,2,3);
plot(t,y(:,1), 'b', t, y(:,2), 'k', t1,m(:,1), 'r', t1, m(:,2), 'g',  t2,m1(:,1), '--r', t2, m1(:,2), '--g'); 
xlabel('time(days)')
ylabel('cell count/ml')
title('Extended Model including Effector Cells with RT Treatment')
legend('targets', 'infected', 'targets - RTT', 'infected - RTT', 'targets - RTT, CD4D ', 'infected - RTT, CD4D') 

subplot(3,2,4); 
semilogy(t, y(:,3), 'k', t1, m(:,3), 'b' , t2, m1(:,3), 'r'); 
xlabel('time(days)')
ylabel('virus titer/ml')
legend('no RTT', 'RTT', 'RTT, CD4D')

[t,y]=ode45(@derivativesEMS, [0 param.t_st], [1e4, 0, 1e-6 ], [], param);
T0RT= y(end,1);

I0RT = y(end,2); 

V0RT = y(end,3);
[t,y]=ode45(@derivativesEMS, [0 250], [1e4, 0, 1e-6 ], [], param);
[t1,m]=ode45(@derivativesEMSRTtreatment, [param.t_st 250], [T0RT I0RT V0RT], [], param);
[t2,m1]=ode45(@derivativesEMSRTtreatment_CD4D, [param.t_st 250], [T0RT I0RT V0RT], [], param);
subplot(3,2,5);
plot(t,y(:,1), 'b', t, y(:,2), 'k', t1,m(:,1), 'r', t1, m(:,2), 'g',  t2,m1(:,1), '--r', t2, m1(:,2), '--g'); 
xlabel('time(days)')
ylabel('cell count/ml')
title('Extended Simplified Model with RT Treatment')
legend('targets', 'infected', 'targets - RTT', 'infected - RTT', 'targets - RTT, CD4D ', 'infected - RTT, CD4D') 

subplot(3,2,6); 
semilogy(t, y(:,3), 'k', t1, m(:,3), 'b' , t2, m1(:,3), 'r'); 
xlabel('time(days)')
ylabel('virus titer/ml')
legend('no RTT', 'RTT', 'RTT, CD4D')
end


