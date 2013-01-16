function treatment = thresholdTreatment(param, initialConditions, duration, threshold)
%Treatment that takes decisions iteratively : if we are below the threshold do nothing
%if above : take treatment using drug with the lowest resistance

nTimeSteps = 40;

%Start by doing nothing...
timeStep = floor(duration / nTimeSteps);

treatment.stepLengths = [timeStep];
treatment.drug1 = [0];
treatment.drug2 = [0];

%We always have nTimeSteps iterations
for i=2:nTimeSteps
    i
   [t,y] = processTreatment(treatment,initialConditions, param); 
    treatment.stepLengths = [treatment.stepLengths timeStep];
   if (y(end,2) > threshold)
      [v,idx] = min([y(end,4) y(end,5)]);
      if idx == 1
         treatment.drug1 = [treatment.drug1 1];
         treatment.drug2 = [treatment.drug2 0];
      else
         treatment.drug1 = [treatment.drug1 0];
         treatment.drug2 = [treatment.drug2 1];
      end
   else
    treatment.drug1 = [treatment.drug1 0];
    treatment.drug2 = [treatment.drug2 0];       
   end
   
end

end