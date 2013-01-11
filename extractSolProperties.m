function [ out ] = extractSolProperties( t,y )

%Extracts potentially interesting properties from the solution of a model.
%Takes as input the time vector and the struct y produced by ODE45.
%
%Calculates:
%maxVirusTiter
%timeMaxVirusTiter
%minTargetCells
%finalVirusTiter
%
%Outputs just one of these, for use in parameter sweeps. To change which is output, 
%alter line 23.

[allResults.maxVirusTiter, time] = max(y(:,3));

allResults.timeMaxVirusTiter = t(time);

allResults.minTargetCells = min(y(:,1));

allResults.finalVirusTiter = y(end,3);

out=allResults.finalVirusTiter;