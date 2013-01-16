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

function [sigma, eigVal] = EigenvaluesEMS(param)
%CALCULATES STABILITY PARAMETER SIGMA AND EIGENVALUES OF INFECTIVE STATE IN
%EMS MODEL
%Takes in the param struct, and outputs a scalar value of sigma and the
%eigenvalues associated with these values in vector of size 2x1.

%Stability analysis is performed as in Appendix B (page 757)
%Find the steady state values of T and I for approximated EMS model
%analytically (equation 11), i.e when 
    %dT/dt = ... = 0
    %dI/dt = ... = 0
%Find two steady states, one healthy and one infected (I2, T2). Analysis reveals
%when parameter sigma = beta'*s/(alpha *d^2) > 1 the infective steady state
%is present but healthy state not stable.
    
%Define variable beta'  = beta*p/c
    param.betadash = (param.beta * param.p)/ param.c;
%Variable sigma = beta'*s/(alpha *d^2).
    sigma = param.betadash * param.s / (param.alpha * param.d^2);

%Eigenvalues, e, of infected steady state for the case of sigma > 1 leads to
%solution of equation
    % e^2 + mu*e + nu = 0 (*)
    
%mu and nu are functions of the steady state equations, I2, T2, which
%themselves are dependent on variables A, B, C i.e.
%   mu(I2(A,B,C),T2(A,B,C))


%Defining all these parameters

    A = param.betadash*(param.k + param.alpha* param.d);

    B = param.alpha*(param.d^2) - param.betadash*param.s + ...
    param.alpha*param.delta*param.betadash*param.theta + param.k*param.d;

    C = param.theta*(param.alpha*(param.d^2) - param.betadash*param.s);

    I2 = (- B + sqrt(B^2 - 4*A*C) )/ (2* A);
    T2 = param.s / (param.d + param.betadash*I2);

    mu = param.d + param.betadash*I2 + param.k*param.theta*I2^2/(I2 + param.theta)^2;
    nu = param.betadash^2*I2*T2 + (param.d + param.betadash*I2)*param.k*param.theta*I2^2/(I2 + param.theta)^2;

%Solving (*) to find eigenvalues
eigVal(1) = (- mu + sqrt(mu^2 - 4*nu) )/2;
eigVal(2) = (- mu - sqrt(mu^2 - 4*nu) )/2;

end
