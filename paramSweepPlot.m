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



function [ ] = paramSweepPlot( parameterStruct, modelDerivativeFunction, initial, computeOutputProperty, percentageChange)

%General function for doing parameter variation. 
%paramSweepPlot plots how some output of your model changes as each parameter is varied.
%You should be able to use it with any coupled ODE model.
%
%Inputs:
%parameterStruct - all the model parameters and starting values in a struct
%modelDerivativeFunction - handle to a function that computes the
%                          derivatives for your model. Same one that you would 
%                          pass to ODE45
%initial - initial values for model 
%computeOutputProperty - handle to a function that computes the output
%                        you're interested in. Should take the t and y 
%                        output by ODE45 and return a single property of interest.                        
%percentageChange - percentage by which to vary the parameter either side
%                   of its usual value
%
% See paramSweepPlotOurModels for example usage. 
% If wanting to use a mex function to speed up solving:
% - write a mex file, copying the format of one of the mex files included
% - comment out line 74
% - update the if case statement on line 75
%





%N = number of points to plot per parameter graph.
N=20;
    
    %Extract starting parameter values, parameter names and number of parameters from struct
    normalParamVals = struct2cell(parameterStruct);
    parameterNames = fieldnames(parameterStruct);
    numberParameters = length(parameterNames);
 
    
    %Calculate normal value of output for sensitivity coefficient purposes
    [t,y]=ode45(modelDerivativeFunction,[0,250],initial,[],parameterStruct);
    normalOutput = computeOutputProperty(t,y);
    
    %loop through all parameters
    for i=1:1:numberParameters
        
        %initialise a vector to store model output. Calculate the parameters
        %values we will sweep through
        results = zeros(1,N);
        testParamVals = linspace((1-percentageChange/100)*normalParamVals{i},(1+percentageChange/100)*normalParamVals{i},N);
        
        %for each test value:
        for j=1:1:N
            
            %set the parameter in the struct to the test value 
            parameterStruct.(parameterNames{i})= testParamVals(j);
            
%________________________________________________________________________%            
            %solve and calculate output
            
            
            %[t,y]=ode45(modelDerivativeFunction,[0,250],initial,[],paramet
            %erStruct);
            if(strcmp(func2str(modelDerivativeFunction),'derivativesTCL')==1)
                [t,y]=ODEmexTCL([0,250],initial,parameterStruct);
            elseif(strcmp(func2str(modelDerivativeFunction),'derivativesEM')==1)
                [t,y]=ODEmexEM([0,250],initial,parameterStruct);
            elseif(strcmp(func2str(modelDerivativeFunction),'derivativesEMS')==1)
                [t,y]=ODEmexEMS([0,250],initial,parameterStruct); 
            else
            end
            %}
%_________________________________________________________________________%

            results(j) = computeOutputProperty(t,y);
        end
        
        subplot(2,ceil(numberParameters/2),i);
        %Ensure all plots have same y axis scale, set equal to first
        %graph's
        if(i==1)
            plot(testParamVals, results);
            set(gca,'xlim',[testParamVals(1) testParamVals(N)])
            storedYAxes = ylim;
        else
            plot(testParamVals, results);
            set(gca,'xlim',[testParamVals(1) testParamVals(N)],'ylim',storedYAxes)
        end
        xlabel(parameterNames(i));
        
        %Calculate and display a sensitivity coefficient for the parameter over this range.
        sensCoef = ((results(N)-results(1))/2*N*normalParamVals{i})/normalOutput;
        fprintf('%s has sensitivity coefficient %f.\n', parameterNames{i}, sensCoef);
        
        %reset the parameter that's been varied to its normal value
        parameterStruct.(parameterNames{i})= normalParamVals{i};
        
    end
