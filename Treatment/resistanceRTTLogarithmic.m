function fval = resistanceRTTLogarithmic(t, y, param, k)

	fval = - k*y(4)*log(y(4)/param.RTT);

end
