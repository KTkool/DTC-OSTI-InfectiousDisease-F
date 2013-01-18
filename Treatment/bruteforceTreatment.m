%{
Copyright 2013 A-team

This file is part of DTC-OSTI-group-A.

DTC-OSTI-group-A is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

DTC-OSTI-group-A is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with DTC-OSTI-group-A. If not, see <http://www.gnu.org/licenses/>.
%}

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

