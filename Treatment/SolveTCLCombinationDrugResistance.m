
function [t,y] = SolveTCLCombinationDrugResistance( param, resolutionDomain, initialConditions, drug1On, drug2On )
% solve the system taking into account which drugs are used
% drug1on = 1 means that drug1 is being used

f = [];
g = [];
if ((drug1On == 0) && (drug2On == 0))
   f = param.fOff;
   g = param.gOff;
elseif ((drug1On == 1) && (drug2On == 0))
    f = param.fOn;
    g = param.gOff;
elseif ((drug1On == 0) && (drug2On == 1))
    f = param.fOff;
    g = param.gOn;
else
    f = param.fOn;
    g = param.gOn;
end;

derivatives = @(t,y) derivativesTCLCombinationDrugResistance(t,y,param,f,g,drug1On,drug2On);
[t,y] = ode45(derivatives, [0 resolutionDomain], initialConditions);

end