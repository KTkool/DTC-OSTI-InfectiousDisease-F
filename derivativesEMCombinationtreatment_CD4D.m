function [ m ] = derivativesEMCombinationtreatment_CD4D( t,y, param )
%Calculates the derivatives for each equation in the extended model with quasi 
%steady state approximation.
%In the model cells are sujected to a combination of protease (PI) and reverse
%transcriptase treatment (RTT). Protease treatment results in the
%production of infectious virus particles (VI) and non-infectious virus
%particles (VNI).CD4D means that CD4 cells will die at a certain rate (dr) due to the drug
% treatment
%To put themodel into a suitable form for MATLAB, each variable has been
%listed as a component in the solution vector y as follows:
%
% T = y(1) = Concentration of target cells
% I = y(2) = Concentration of infected cells
% VI = y(3) = Serum virus concentration (infectious)
% VNI = y(4) = Serum virus concentration (non-infectious)
% E = y(5) = Concentration of immune effector cells

m = zeros(5,1);

m(1) = param.s-(param.dr + param.d)*y(1)-(1-param.RTT)*param.beta*y(1)*y(3);

m(2) = (1-param.RTT)*param.beta*y(1)*y(3)-(param.dr + param.alpha*param.d + param.k0*y(4))*y(2);

m(3) = (1- param.PI)*param.alpha*param.d*param.p*y(2)-param.c*y(3);

m(4) = param.PI* param.alpha *param.d *param.p*y(2)-param.c*y(4);

m(5) = param.a_E*y(2)/(param.theta+y(2))-param.d_E*y(5);



end