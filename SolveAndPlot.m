function [ y ] = SolveAndPlot()
% Solves ODEs of models one and two using ODE45
%   

clear;
params;

%RTT=0.5;

[t,y]=ode45(@derivativesTCL, [0 param.t_st], [1e4, 0, 1e-6 ], [], param);
T0RT= y(end,1);

I0RT = y(end,2); 

V0RT = y(end,3);

[t1,m]=ode45(@derivativesTCLRTtreatment, [param.t_st 250], [T0RT I0RT V0RT], [], param);

subplot(3,2,1);
plot(t,y(:,1), 'r', t, y(:,2), 'g', t1,m(:,1), 'r', t1, m(:,2), 'g'); 
xlabel('time(days)')
ylabel('cell count/ml')
title('Simple Model')
legend('targets', 'infected') 

subplot(3,2,2); 
semilogy(t, y(:,3), 'k', t1, m(:,3), 'k'); 
xlabel('time(days)')
ylabel('virus titer')

[t,y]=ode45(@derivativesEM, [0 param.t_st], [1e4, 0, 1e-6 ,10], [], param);
T0RT= y(end,1);

I0RT = y(end,2); 

V0RT = y(end,3);

E0RT = y(end,4);

[t1,m]=ode45(@derivativesEMRTtreatment, [param.t_st 250], [T0RT I0RT V0RT E0RT], [], param);
subplot(3,2,3);
plot(t,y(:,1), 'r', t, y(:,2), 'g', t1,m(:,1), 'r', t1, m(:,2), 'g'); 
xlabel('time(days)')
ylabel('cell count/ml')
title('Extended Model including Effector Cells')
legend('targets', 'infected') 

subplot(3,2,4); 
semilogy(t, y(:,3), 'k', t1, m(:,3), 'k'); 
xlabel('time(days)')
ylabel('virus titer')

[t,y]=ode45(@derivativesEMS, [0 param.t_st], [1e4, 0, 1e-6 ], [], param);
T0RT= y(end,1);

I0RT = y(end,2); 

V0RT = y(end,3);

[t1,m]=ode45(@derivativesEMSRTtreatment, [param.t_st 250], [T0RT I0RT V0RT], [], param);

subplot(3,2,5);
plot(t,y(:,1), 'r', t, y(:,2), 'g', t1,m(:,1), 'r', t1, m(:,2), 'g'); 
xlabel('time(days)')
ylabel('cell count/ml')
title('Extended Simplified Model')
legend('targets', 'infected') 

subplot(3,2,6); 
semilogy(t, y(:,3), 'k', t1, m(:,3), 'k'); 
xlabel('time(days)')
ylabel('virus titer')

end


