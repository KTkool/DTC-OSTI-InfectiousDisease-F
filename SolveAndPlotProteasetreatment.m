function [ y ] = SolveAndPlotRTtreatment()
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
[t1,m]=ode45(@derivativesTCLProteasetreatment, [param.t_st 250], [T0RT I0RT V0RT 0], [], param);

subplot(3,2,1);
plot(t,y(:,1), 'b', t, y(:,2), 'k', t1,m(:,1), 'r', t1, m(:,2), 'g'); 
xlabel('time(days)')
ylabel('cell count/ml')
title('Simple Model with ProteaseTtreatment')
legend('targets', 'infected', 'targets - PT', 'infected - PT') 

subplot(3,2,2); 
semilogy(t, y(:,3), 'k', t1, m(:,3), 'b', t1, m(:,4), '--r'); 
xlabel('time(days)')
ylabel('virus titer/ml')
legend('no PT', 'PT - infectious', 'PT - non-infectious') 

[t,y]=ode45(@derivativesEM, [0 param.t_st], [1e4, 0, 1e-6 ,10], [], param);
T0RT= y(end,1);

I0RT = y(end,2); 

V0RT = y(end,3);

E0RT = y(end,4);
[t,y]=ode45(@derivativesEM, [0 250], [1e4, 0, 1e-6 ,10], [], param);
[t1,m]=ode45(@derivativesEMProteasetreatment, [param.t_st 250], [T0RT I0RT V0RT 0 E0RT], [], param);
subplot(3,2,3);
plot(t,y(:,1), 'k', t, y(:,2), 'b', t1,m(:,1), 'r', t1, m(:,2), 'g'); 
xlabel('time(days)')
ylabel('cell count/ml')
title('Extended Model including Effector Cells with Protease Treatment')
legend('targets', 'infected', 'targets - PT', 'infected - PT') 

subplot(3,2,4); 
semilogy(t, y(:,3), 'k', t1, m(:,3), 'b', t1, m(:,4), '--r'); 
xlabel('time(days)')
ylabel('virus titer/ml')
legend('no PT', 'PT - infectious', 'PT - non-infectious') 

[t,y]=ode45(@derivativesEMS, [0 param.t_st], [1e4, 0, 1e-6 ], [], param);
T0RT= y(end,1);

I0RT = y(end,2); 

V0RT = y(end,3);
[t,y]=ode45(@derivativesEMS, [0 250], [1e4, 0, 1e-6 ], [], param);
[t1,m]=ode45(@derivativesEMSProteasetreatment, [param.t_st 250], [T0RT I0RT V0RT 0 ], [], param);

subplot(3,2,5);
plot(t,y(:,1), 'k', t, y(:,2), 'b', t1,m(:,1), 'r', t1, m(:,2), 'g'); 
xlabel('time(days)')
ylabel('cell count/ml')
title('Extended Simplified Model with Protease Treatment')
legend('targets', 'infected', 'targets - PT', 'infected - PT')  

subplot(3,2,6); 
semilogy(t, y(:,3), 'k', t1, m(:,3), 'b', t1, m(:,4), '--r'); 
xlabel('time(days)')
ylabel('virus titer/ml')
legend('no PT', 'PT - infectious', 'PT - non-infectious') 

end


