function [ dy ] = derivativesQS( t,y, param )
%Calculates the derivatives for each equation in the extended model with quasi 
%steady state approximation. 
%To put the model into a suitable form for MATLAB, each variable has been
%listed as a component in the solution vector y as follows:
%
% T = y(1) = Concentration of target cells
% I = y(2) = Concentration of infected cells
% V = y(3) = Serum virus concentration

dy = zeros(3,1);

dy(1) = param.s-param.d*y(1)-param.beta*y(1)*y(3);

dy(2) = param.beta*y(1)*y(3)-(param.alpha*param.d + param.k*y(2)/(y(2)+param.theta))*y(2);

dy(3) = param.p*y(2)-param.c*y(3);


end