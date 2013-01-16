function fval = resistanceRTTLogarithmic(t, y, param, k)
	fval = - k*y(4)*ln(y(4)/param.RTT);
end
