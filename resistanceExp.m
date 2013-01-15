
function fval = resistanceExp( t, y, param, k )
% gives the effectiveness of the drug

%fval = k;
% logistic for RTT---Sorry same function for both is not possible
fval = param.RTT - k*y(4)*(1-y(4)/param.RTT);
% for PI it would be:
% fval = param.PI - k*y(5)*(1-y(5)/param.PI);

% logarithmic
fval = param.RTT + k*y(4)*ln(y(4)/param.RTT);
% for PI it would be:
% fval = param.PI + k*y(5)*ln(y(5)/param.PI);

end