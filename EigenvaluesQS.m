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
