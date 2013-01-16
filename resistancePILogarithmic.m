function fval = resistancePILogarithmic(t, y, param, k)

fval = - k*y(5)*ln(y(5)/param.PI);
end
