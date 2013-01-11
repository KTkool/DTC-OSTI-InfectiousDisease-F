%STABILITY ANALYSIS: Calculates the stability criteria value R_0 for the
%TCL system and also outputs Eigenvalues of Infected steady state.
function [R_0, eigVal] = EigenvaluesTCL(param);
param.betadash = (param.beta * param.p)/ param.c;

R_0 = param.betadash*param.s/(param.d*param.delta);

Jacobian = [-param.betadash*param.s/param.delta, -param.delta; ...
            -param.betadash*param.s/param.delta - param.d, 0];
        
[eigVec, eigVal] = eig(Jacobian);

end

    
    
        

