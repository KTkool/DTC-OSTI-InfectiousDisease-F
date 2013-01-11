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

