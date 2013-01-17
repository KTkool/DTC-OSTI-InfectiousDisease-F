function v = objectiveFunction(t,y)

%Compute the integral using a trapezoidal method
v = trapz(t,real(y));

end