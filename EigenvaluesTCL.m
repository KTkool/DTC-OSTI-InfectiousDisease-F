%STABILITY ANALYSIS: Calculates the Jacobian of the target-cell-limited
%model and determines if eigenvalues are imaginary.

Jacobian = [-param.betadash*param.s/param.delta, -param.delta; ...
            -param.betadash*param.s/param.delta - param.d, 0];
        
[eigVec, eigVal] = eig(Jacobian);


if(real(eigVal(1,1)) < 0 && real(eigVal(2,2)) < 0)
    stability=1;
    disp('This is a point of stability!');
else
    stability=0;
    disp('This is not a point of stability!');
end

if(imag(eigVal(1,1)) ~= 0)
    disp('(1,1) is an imaginary eigenvalue')
else
    disp('Not imaginary');
end

    
if(imag(eigVal(2,2)) ~= 0)
    disp('(2,2) is an imaginary eigenvalue')
else
    disp('Not imaginary');
end

%Test for consistency between two indicators of chronic infection:
%1) Stability of infected steady state from jacobian
%2) R0 > 1
R_0 = param.betadash*param.s/(param.d*param.delta);

if(R_0>1 && stability == 1)
    
disp('Something is wrong with your parameters');
end


    
    
        

