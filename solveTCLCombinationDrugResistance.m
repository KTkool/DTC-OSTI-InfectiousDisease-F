
function [t,y] = solveTCLCombinationDrugResistance( param, resolutionDomain, initialConditions, drug1on, drug2On )
% solve the system taking into account which drugs are used
% drug1on = 1 means that drug1 is being used

f = [];
g = [];
if ((drug1on == 0) && (drug2on == 0))
   f = param.fOff;
   g = param.gOff;
elseif ((drug1on == 1) && (drug2on == 0))
    f = param.fOn;
    g = param.gOff;
elseif ((drug1on == 0) && (drug2on == 1))
    f = param.fOff;
    g = param.gOn;
else
    f = param.fOn;
    g = param.gOn;
end;

[t,y] = ode45(@derivativesTCLCombinationDrugResistance, [0 resolutionDomain], initialConditions,[],param,f,g);

end