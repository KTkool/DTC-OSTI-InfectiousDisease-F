
function [t,y] = SolveTCLCombinationDrugResistance( param, resolutionDomain, initialConditions, drug1On, drug2On )
% solve the system taking into account which drugs are used
% drug1on = 1 means that drug1 is being used

tol = 0.05;

f = [];
g = [];
if ((drug1On < tol) && (drug2On < tol))
   f = param.fOff;
   g = param.gOff;
elseif ((drug1On >= tol) && (drug2On < tol))
    f = param.fOn;
    g = param.gOff;
elseif ((drug1On < tol) && (drug2On >= tol))
    f = param.fOff;
    g = param.gOn;
else
    f = param.fOn;
    g = param.gOn;
end;

derivatives = @(t,y) derivativesTCLCombinationDrugResistance(t,y,param,f,g,drug1On,drug2On);
[t,y] = ode15s(derivatives, [0 resolutionDomain], initialConditions);

end