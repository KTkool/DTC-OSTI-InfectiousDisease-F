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

function treatment = thresholdTreatment(param, initialConditions, duration, threshold)
%Treatment that takes decisions iteratively : if we are below the threshold do nothing
%if above : take treatment using drug with the lowest resistance

%Note : This file is here for historical reasons and output results.
%They are, however, completely meaningless.

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