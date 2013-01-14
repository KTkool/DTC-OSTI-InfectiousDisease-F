%{
Copyright 2013 Kathryn Atwell
	
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
    

%TCL model params

%influx rate of target cells
param.s = 100;

%target cell loss rate
param.d = 0.01;

%target cell infection rate constant
param.beta = 1.3e-6;

%infected cell loss rate
param.delta = 0.5;


%virus production rate
param.p = 1000;

%virus clearance rate 
param.c = 3;

%_________________________________________________________________________

%Extended model params

%how cytopathic is the virus? alpha>1 => virus kills cells above and beyond
%normal death rate 
param.alpha = 1;

%half maximal effector cell stimulation threshhold 
param.theta = 3;

%depletion rate of infected cells by immune efector cells
%UNKNOWN
param.k0 = 0.2;

%rate of production of effector cells
param.a_E = 5;
%UNKNOWN

%rate of loss of effector cells
param.d_E = 1;
%UNKNOWN

%__________________________________________________________________________

%Quasi steady state extended model params

param.k = 1; %param.k0*param.a_E/param.d_E = 1;
