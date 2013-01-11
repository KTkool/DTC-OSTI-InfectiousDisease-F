function [sigma, eigVal] = EigenvalueQS(param);

sigma = param.betadash * param.s / (param.alpha * param.d^2);

A = param.betadash*(param.k + param.alpha* param.d);

B = param.alpha*(param.d^2) - param.betadash*param.s + ...
    param.alpha*param.delta*param.betadash*param.theta + param.k*param.d;

C = param.theta*(param.alpha*(param.d^2) - param.betadash*param.s);

I2 = (- B + sqrt(B^2 - 4*A*C) )/ (2* A);
T2 = param.s / (param.d + param.betadash*I2);

mu = param.d + param.betadash*I2 + param.k*param.theta*I2^2/(I2 + param.theta)^2;
nu = param.betadash^2*I2*T2 + (param.d + param.betadash*I2)*param.k*param.theta*I2^2/(I2 + param.theta)^2;

eigVal(1) = (- mu + sqrt(mu^2 - 4*nu) )/2;
eigVal(2) = (- mu - sqrt(mu^2 - 4*nu) )/2;

end
