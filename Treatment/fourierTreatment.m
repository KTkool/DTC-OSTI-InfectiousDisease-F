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

function [ treatment ] = fourierTreatment(param,initialConditions,duration)

basisSize = 10;
%Main assumption : the treament is going to be periodic.
nIter = 10;
epsilon = 0.1;
%Use a constant learning rate
learningRate = 0.01;
%Idea is simple : start with no treatment ; then do stochastic gradient
%descent on it.
range = 0.1;
an1 = range.*rand(basisSize,1);
bn1 = range.*rand(basisSize,1);

an2 = range.*rand(basisSize,1);
bn2 = range.*rand(basisSize,1);

%Start treament 100 days after infection
offset = 100;

nSteps = 10;
stepLength = floor(duration/nSteps);
duration = nSteps;
offset = floor(offset/stepLength);
%FIXME : Obviously BAAAAAAAAAAD to use timesteps of one
treatment.stepLengths = stepLength*ones(nSteps, 1);
treatment.drug1 = [zeros(1,offset) arrayfun(@(t) pseudoFourier.expressFunction(an1,bn1,t),offset:nSteps)];
treatment.drug2 = [zeros(1,offset) arrayfun(@(t) pseudoFourier.expressFunction(an2,bn2,t),offset:nSteps)];
for i=1:nIter
    i
    [t, y] = processTreatment(treatment,initialConditions,param);
    value = -objectiveFunction(t,y(:,1))
    %Pick some parameter at random
    idx = randsample(4*basisSize,1);
    %Move the fst parameter and record the value of the objective function
    if (idx <= basisSize)
        p = an1;
        p(idx) = p(idx) + epsilon;
        treatment.drug1 = [zeros(1,offset)  arrayfun(@(t) pseudoFourier.expressFunction(p,bn1,t),offset:duration)];
        [t, y] = processTreatment(treatment,initialConditions,param);
        valueEpsilon = -objectiveFunction(t,y(:,1));
        gradient = (valueEpsilon - value) / epsilon;
        %Update this parameter accordingly
        an1(idx) = an1(idx) - learningRate*gradient;
        treatment.drug1 = [zeros(1,offset) arrayfun(@(t) pseudoFourier.expressFunction(an1,bn1,t),offset:duration)];
    elseif(idx <= 2*basisSize)
        idx = idx - basisSize;
        p = bn1;
        p(idx) = p(idx) + epsilon;
        treatment.drug1 = [zeros(1,offset) arrayfun(@(t) pseudoFourier.expressFunction(an1,p,t),offset:duration)];
        [t, y] = processTreatment(treatment,initialConditions,param);
        valueEpsilon = -objectiveFunction(t,y(:,1));
        gradient = (valueEpsilon - value) / epsilon;
        %Update this parameter accordingly
        bn1(idx) = bn1(idx) - learningRate*gradient;
        treatment.drug1 = [zeros(1,offset) arrayfun(@(t) pseudoFourier.expressFunction(an1,bn1,t),offset:duration)];
    elseif(idx <= 3*basisSize)
        idx = idx - 2*basisSize;
        p = an2;
        p(idx) = p(idx) + epsilon;
        treatment.drug2 = [zeros(1,offset) arrayfun(@(t) pseudoFourier.expressFunction(p,bn2,t),offset:duration)];
        [t, y] = processTreatment(treatment,initialConditions,param);
        valueEpsilon = -objectiveFunction(t,y(:,1));
        gradient = (valueEpsilon - value) / epsilon;
        %Update this parameter accordingly
        an2(idx) = an2(idx) - learningRate*gradient;
        treatment.drug2 = [zeros(1,offset) arrayfun(@(t) pseudoFourier.expressFunction(an2,bn2,t),offset:duration)];
    else
        idx = idx - 3*basisSize;
        p = bn2;
        p(idx) = p(idx) + epsilon;
        treatment.drug2 = [zeros(1,offset) arrayfun(@(t) pseudoFourier.expressFunction(an2,p,t),offset:duration)];
        [t, y] = processTreatment(treatment,initialConditions,param);
        valueEpsilon = -objectiveFunction(t,y(:,1));
        gradient = (valueEpsilon - value) / epsilon;
        %Update this parameter accordingly
        bn2(idx) = bn2(idx) - learningRate*gradient;
        treatment.drug2 = [zeros(1,offset) arrayfun(@(t) pseudoFourier.expressFunction(an2,bn2,t),offset:duration)];
    end;
end;

end

