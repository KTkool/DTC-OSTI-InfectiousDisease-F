
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
