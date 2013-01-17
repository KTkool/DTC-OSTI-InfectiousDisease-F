function [ v ] = expressFunction(an, bn, x)
%EXPRESSFUNCTION take the coeffs and returns the value in x of
% the function they represent

v = real(sum(arrayfun(@(t) an(t)*cos(t*x),1:length(an)) + arrayfun(@(t) bn(t)*sin(t*x),1:length(an))));
%It's a concentration : make sure it's between 0 and 1
v = min(v,1);
v = max(v,0);
end

