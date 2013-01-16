function fval = resistancePILogistic( t, y, param, k)
% gives the resistance against the drug
% yes, it actually does!, to code up drug effectiveness we need
% param.RTT-the value obtained from solving this differential equation.
% I can give you closed form for these equations, but that will be a bit of
% a pain to implement with initial conditions. AKM
fval = k*y(5)*(1-y(5)/param.PI);
end
