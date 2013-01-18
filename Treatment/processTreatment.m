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

function [t,y] = processTreatment(treatment, initialConditions, param)
%Function that takes a treatment and returns the effect of this treatment
%on the patient.

%Treatment is a structure, with the following parameters
% treatment.stepLengths : A vector indicating for how long some drug
% combination should be taken
% treatment.drug1 : A vector of size treatment.stepLengths indicating
% whether drug1 should be taken during this phase of the treatment
% treatment.drug2 : cf. drug1

y = [initialConditions];
t = [0];
for i=1:length(treatment.stepLengths)
    [t1,y1] = SolveTCLCombinationDrugResistance( param, treatment.stepLengths(i), y(end,:), treatment.drug1(i), treatment.drug2(i));
    t = [t ; t1 + t(end)];
    y = [y ; y1];
end;

end


% initial conditions y(4) and y(5) = 0.012 ish
