%{
Copyright 2013 Adam Berrington
	
This file is part of DTC-OSTI-InfectiousDisease-F.

DTC-OSTI-InfectiousDisease-F is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

DTC-OSTI-InfectiousDisease-F is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with DTC-OSTI-InfectiousDisease-F. If not, see <http://www.gnu.org/licenses/>.
%}

function [sigma, eigVal] = EigenvalueQS(param);

sigma = param.betadash * param.s / (param.alpha * param.d^2);

A = param.betadash*(param.k + param.alpha* param.d);

B = param.alpha*(param.d^2) - param.betadash*param.s + ...
    param.alpha*param.delta*param.betadash*param.theta + param.k*param.d;

C = param.theta*(param.alpha*(param.d^2) - param.betadash*param.s);

I2 = (- B + sqrt(B^2 - 4*A*C) )/ (2* A);
T2 = param.s / (param.d + param.betadash*I2);

mu = param.d + param.betadash*I2 + param.k*param.theta*I2^2/(I2 + param.theta)^2;
nu = param.betadash^2*I2*T2 + (param.d + param.betadash*I2)*param.k*param.theta*I2^2/(I2 + param.theta)^2;

eigVal(1) = (- mu + sqrt(mu^2 - 4*nu) )/2;
eigVal(2) = (- mu - sqrt(mu^2 - 4*nu) )/2;

end
