function fval = resistanceRTTLogistic( t, y, param, k)
% gives the resistance against the drug
% yes, it actually does!, to code up drug effectiveness we need
% param.RTT-the value obtained from solving this differential equation.
% I can give you closed form for these equations, but that will be a bit of
% a pain to implement with initial conditions. AKM

%fval = k;
% logistic for RTT---Sorry same function for both is not possible
fval = k*y(4)*(1-y(4)/param.RTT);

end
