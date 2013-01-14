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

function [ y ] = SolveAndPlotProteasetreatment_CD4D()
% Solves  and plot ODEs of all three HIV infection models using ODE45
% All functions assume subjection to PROTEASE INHIBITOR treatment after a time t_st
% CD4D means that CD4 cells will die at a certain rate due to the drug
% treatment   

clear;
params;

%SIMPLE MODEL

[t,y]=ode45(@derivativesTCL, [0 param.t_st], [1e4, 0, 1e-6 ], [], param);
T0RT= y(end,1);%INITIAL CONITITIONS FOR TREATMENT


I0RT = y(end,2); 

V0RT = y(end,3);
[t,y]=ode45(@derivativesTCL, [0 250], [1e4, 0, 1e-6 ], [], param);
[t1,m]=ode45(@derivativesTCLProteasetreatment, [param.t_st 250], [T0RT I0RT V0RT 0], [], param);
[t2,m1]=ode45(@derivativesTCLProteasetreatment_CD4D, [param.t_st 250], [T0RT I0RT V0RT 0], [], param);

subplot(3,2,1);
plot(t,y(:,1), 'b', t, y(:,2), 'k', t1,m(:,1), 'r', t1, m(:,2), 'g' ,t2,m1(:,1), '--r', t2, m1(:,2), '--g'); 
xlabel('time(days)')
ylabel('cell count/ml')
title('Simple Model with ProteaseTtreatment')
legend('targets', 'infected', 'targets - PT', 'infected - PT, CD4D' , 'targets - PT, CD4D', 'infected - PT, CD4D') 

subplot(3,2,2); 
semilogy(t, y(:,3), 'k', t1, m(:,3), 'b', t1, m(:,4), '--r', t2, m1(:,3), '--g', t2, m1(:,4), 'g'); 
xlabel('time(days)')
ylabel('virus titer/ml')
legend('no PT', 'PT - infectious', 'PT - non-infectious', 'PT - infectious, CD4D', 'PT - non-infectious, CD4D') 

%EXTENDED MODEL

[t,y]=ode45(@derivativesEM, [0 param.t_st], [1e4, 0, 1e-6 ,10], [], param);
T0RT= y(end,1);%INITIAL CONITITIONS FOR TREATMENT


I0RT = y(end,2); 

V0RT = y(end,3);

E0RT = y(end,4);
[t,y]=ode45(@derivativesEM, [0 250], [1e4, 0, 1e-6 ,10], [], param);
[t1,m]=ode45(@derivativesEMProteasetreatment, [param.t_st 250], [T0RT I0RT V0RT 0 E0RT], [], param);
[t2,m1]=ode45(@derivativesEMProteasetreatment_CD4D, [param.t_st 250], [T0RT I0RT V0RT 0 E0RT], [], param);
subplot(3,2,3);
plot(t,y(:,1), 'b', t, y(:,2), 'k', t1,m(:,1), 'r', t1, m(:,2), 'g' ,t2,m1(:,1), '--r', t2, m1(:,2), '--g'); 
xlabel('time(days)')
ylabel('cell count/ml')
title('Extended Model including Effector Cells with Protease Treatment')
legend('targets', 'infected', 'targets - PT', 'infected - PT') 

subplot(3,2,4); 
semilogy(t, y(:,3), 'k', t1, m(:,3), 'b', t1, m(:,4), '--r', t2, m1(:,3), '--g', t2, m1(:,4), 'g'); 
xlabel('time(days)')
ylabel('virus titer/ml')
legend('no PT', 'PT - infectious', 'PT - non-infectious', 'PT - infectious, CD4D', 'PT - non-infectious, CD4D') 

%SIMPLYFIED EXTENDED MODEL
[t,y]=ode45(@derivativesEMS, [0 param.t_st], [1e4, 0, 1e-6 ], [], param);
T0RT= y(end,1);%INITIAL CONITITIONS FOR TREATMENT

I0RT = y(end,2); 

V0RT = y(end,3);
[t,y]=ode45(@derivativesEMS, [0 250], [1e4, 0, 1e-6 ], [], param);
[t1,m]=ode45(@derivativesEMSProteasetreatment, [param.t_st 250], [T0RT I0RT V0RT 0 ], [], param);

subplot(3,2,5);
plot(t,y(:,1), 'b', t, y(:,2), 'k', t1,m(:,1), 'r', t1, m(:,2), 'g' ,t2,m1(:,1), '--r', t2, m1(:,2), '--g'); 
xlabel('time(days)')
ylabel('cell count/ml')
title('Extended Simplified Model with Protease Treatment')
legend('targets', 'infected', 'targets - PT', 'infected - PT, CD4D' , 'targets - PT, CD4D', 'infected - PT, CD4D')  

subplot(3,2,6); 
semilogy(t, y(:,3), 'k', t1, m(:,3), 'b', t1, m(:,4), '--r', t2, m1(:,3), '--g', t2, m1(:,4), 'g'); 
xlabel('time(days)')
ylabel('virus titer/ml')
legend('no PT', 'PT - infectious', 'PT - non-infectious', 'PT - infectious, CD4D', 'PT - non-infectious, CD4D') 

end


