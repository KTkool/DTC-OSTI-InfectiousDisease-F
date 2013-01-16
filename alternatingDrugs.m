function treatment = alternatingDrugs(duration,timeStep)
%Very basic treatment : Alternating drugs 1 and 2.

nTimeSteps = floor(duration/timeStep);
treatment.stepLengths = arrayfun(@(n) timeStep, ones(1,nTimeSteps));

for i=2:nTimeSteps
   treatment.drug1(i) = mod(i,2);
   treatment.drug2(i) = mod(i + 1,2);
end

end