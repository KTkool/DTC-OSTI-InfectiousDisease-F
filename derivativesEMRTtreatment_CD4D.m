function [ m ] = derivativesEMRTtreatment_CD4D( t,y, param )
%Calculates the derivatives for each equation in the extended model with quasi 
%steady state approximation. 
%To put themodel into a suitable form for MATLAB, each variable has been
%listed as a component in the solution vector y as follows:
%
% T = y(1) = Concentration of target cells
% I = y(2) = Concentration of infected cells
% V = y(3) = Serum virus concentration
% E = y(4) = Concentration of immune effector cells

m = zeros(4,1);

m(1) = param.s-(param.dr + param.d)*y(1)-(1-param.RTT)*param.beta*y(1)*y(3);

m(2) = (1-param.RTT)*param.beta*y(1)*y(3)-(param.dr + param.alpha*param.d + param.k0*y(4))*y(2);

m(3) = param.p*y(2)-param.c*y(3);

m(4) = param.a_E*y(2)/(param.theta+y(2))-param.d_E*y(4);



end