DTC-OSTI-InfectiousDisease-F
============================

Repository for the MATLAB course assessment phase 1

General information:
Our paper (doi: 10.1016/j.jtbi.2009.04.010) contains 3 models of HIV infection
1) Target Cell Limited
2) Extended Model
3) Extended Model (Simplified Version)
So far our code allows each of these models to be solved, and graphs of each variable
to be plotted.


FILES
!If you add a file, write the name and what it does here!

params.m
Script that generates a struct called "param", containing all the parameters found in all 
3 models.
Parameters are initialised to sensible values; the ones used in the graphs in the paper.
For the extended model, three parameters are not estimated or given in the paper. These are
marked UNKNOWN in the comments and have been initialised to values of a reasonable order of magnitude.
This script isnt convenient for varying parameters, but is useful for quickly setting up some
sensible parameter values when testing other code.

derivativesTCL.m
Function that calculates the derivatives for the "Target Cell Limited" model, equations 1-3 in the paper.
For use as an input to ode45.

derivativesEM.m
Function that calculates the derivatives for the "Extended Model", equations 4-7 in the paper.
For use as an input to ode45

derivativesEMS.m
Function that calculates the derivatives for the simplified "Extended Model with Quasi Steady
State Assumption", equations 8-10 in the paper.
For use as an input to ode45.

SolveAndPlot.m
Function that solves all 3 models and for each one plots as a function of time: 
1) target and infected cell populations on the same axes (linear scale) 
2) virus titer (y axis log scale)

EigenvaluesTCL.m
For a given set of parameters, indicates whether the infected steady state of the Target Cell
Limited Model is stable. Does this by checking for eigenvalues of the jacobian with positive
real part. A test like this function will eventually be incorporated into our GUI, giving 
info on stability of fixed points as soon as parameters are entered.

EigenvaluesQS.m
For given paramaters, calculates whether a steady infective state exists or not in the Extended Model with 
Quasi Steady State Assumption. Plots the stability criterion graph Appendix B on paper, to see if a root and hence
a solution exists. 


PhasePlaneTCL.m
Solves the Target Cell Limited Model and outputs a phase plane plot of a pair of the model
variables e.g. T against V. Takes two inputs, which indicate which variables to plot.
