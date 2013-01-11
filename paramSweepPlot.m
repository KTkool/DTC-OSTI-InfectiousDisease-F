function [ ] = paramSweepPlot( parameterStruct, modelDerivativeFunction, initial, computeOutputProperty, percentageChange)

%Really general function for doing parameter sweeps. 
%paramSweepPlot plots how some output of your model changes as each parameter is varied.
%You should be able to use it with any coupled ODE model.
%
%Inputs:
%parameterStruct - all the model parameters and starting values in a struct
%modelDerivativeFunction - handle to a function that computes the
%                          derivatives for your model. Same one you would 
%                          pass to ODE45
%initial - initial values for model variables
%computeOutputProperty - handle to a function that computes the output
%                        you're interested in. Should take the t and y 
%                        output by ODE45 and return a single property of interest.                        
%percentageChange - percentage by which to vary the parameter either side
%                   of its usual value
%
% E.g. params;
%      paramSweepPlot(param,@derivativesTCL,@extractSolProperties,10);
%





%N = number of points to plot per parameter.
N=20;
    
    %Extract starting parameter values, names and number of parameters from struct
    normalParamVals = struct2cell(parameterStruct);
    parameterNames = fieldnames(parameterStruct);
    numberParameters = length(parameterNames);
 
    %loop through all parameters
    for i=1:1:numberParameters
        
        %initialise a vector to store results. Calculate the parameters
        %values we will sweep through
        results = zeros(1,N);
        testParamVals = linspace((1-percentageChange/100)*normalParamVals{i},(1+percentageChange/100)*normalParamVals{i},N);
        
        %for each test value:
        for j=1:1:N
            
            %set the parameter to test value 
            parameterStruct.(parameterNames{i})= testParamVals(j);
            %solve and calculate output
            [t,y]=ode45(modelDerivativeFunction,[0,250],initial,[],parameterStruct);
            results(j) = computeOutputProperty(t,y);
        
        end
        
        subplot(2,ceil(numberParameters/2),i)
        plot(testParamVals, results);
        xlabel(parameterNames(i));
        ylabel('Final Virus Titer')
        
        %reset the parameter that's been varied to its normal value
        parameterStruct.(parameterNames{i})= normalParamVals{i};
        
    end
    


