function [ dy ] = derivativesTCLRTtreatment( t, y, param )
%Calculates the derivatives for each equation in the target cell limited model. 
%To put themodel into a suitable form for MATLAB, each variable has been
%listed as a component in the solution vector y as follows:
%
% T = y(1) = Concentration of target cells
% I = y(2) = Concentration of infected cells
% V = y(3) = Serum virus concentration

dy=zeros(3,1);
dy(1) = param.s - param.d*y(1)- (1-param.RTT)*param.beta*y(1)*y(3);
dy(2) = (1-param.RTT)*param.beta*y(1)*y(3)- param.delta*y(2);
dy(3) = param.p*y(2)-param.c*y(3);

end