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
plot(t, y(:,3), 'k');
xlabel('time(days)')
ylabel('virus titer')

[t,y]=ode45(@derivativesEM, [0 250], [1e4, 0, 1e-6 ,100], [], param);

subplot(3,2,3);
semilogy(t,y(:,1), 'r', t, y(:,2), 'g');
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


