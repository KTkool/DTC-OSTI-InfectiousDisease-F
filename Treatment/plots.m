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

close all


figure

subplot(2,2,1)
plot(t,y(:,1), 'k')
ylim( [0,10000] );
title('Target Cells')
xlabel('days')
ylabel('cells/ml')
%hold on
%area([100 200], [max(y(:,1)) max(y(:,1))]);

subplot(2,2,2)
plot(t,y(:,2), 'k')
%ylim( [0,10000] );
title('Infected Cells')
xlabel('days')
ylabel('cells/ml')

subplot(2,2,3)
plot(t,y(:,3), 'k')
title('Virus titre')
xlabel('days')
ylabel('RNAcopies/ml')

subplot(2,2,4)
plot(t,y(:,4), 'b-'), hold on
plot(t,y(:,5), 'r--'), hold on
%ylim([0 1])
%plot(seq,y(seq,4), 'bo'), hold on
%plot(seq,y(seq,5), 'rx'), hold on
title('Resistance')
xlabel('days')
ylabel('resistance')
legend('drug1','drug2', 'Location', 'NorthWest')


