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
function treatment = alternatingDrugs(duration,timeStep)
%Very basic treatment : Alternating drugs 1 and 2.

nTimeSteps = floor(duration/timeStep);
treatment.stepLengths = arrayfun(@(n) timeStep, ones(1,nTimeSteps));

for i=2:nTimeSteps
   treatment.drug1(i) = mod(i,2);
   treatment.drug2(i) = mod(i + 1,2);
end

end