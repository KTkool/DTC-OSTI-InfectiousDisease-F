function [ treatment ] = bruteforceTreatment( param, initialConditions, duration )
%BRUTEFORCETREATMENT Tries all possible combinations

maxIter = 6;
timeStep = floor(maxIter/duration)

treatment.stepLengths = timeStep*ones(maxIter,100);
treatment.drug1 = zeros(1,maxIter);
treatment.drug2 = zeros(1,maxIter);
bestValue = 0;
bestTreatment = treatment;


function tr = createTreatment(index)
    %Treatments are actually computed in base 4
    % and then each number between 
end;

%All treatments start by 0 0 (so give enough time to the virus to develop).
%Then we have to try all possible combinations 4*(maxIter -1)
for i=1:4*(maxIter -1)
    %Create treatment corresponding to this number
    treatment = createTreatment(i);
    %Solve
    [t,y]=processTreatment(treatment,initialConditions,param);
    %Compute the 'cost' function (actually we try to maximize it)
    v = objectiveFunction(t,y(:1));
    if (v > bestValue)
        bestValue = v;
        bestTreatment = treatment;
    end;
end

