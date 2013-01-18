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

% a run

params;
%treatment=alternatingDrugs(2000,50);
treatment.stepLengths = [100 200 500];
treatment.drug1 = [0 0 0];
treatment.drug2 = [0 0 0];
[t,y]=processTreatment(treatment,[1000,10,0.0001,0.1,0.1],param);
subplot(2,2,1)
plot(t,y(:,1))
subplot(2,2,2)
plot(t,y(:,2))
subplot(2,2,3)
plot(t,y(:,4))
subplot(2,2,4)
plot(t,y(:,5))
