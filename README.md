DTC-OSTI-InfectiousDisease-F
============================

Repository for the MATLAB course assessment, phase 1

GENERAL INFORMATION: 
Our paper (doi: 10.1016/j.jtbi.2009.04.010) contains 3 models of HIV infection 1) Target Cell Limited, TCL 2) Extended Model, EM 3)  Extended Model Simplified, EMS (Simplified with quasi steady state assumption). 

WHAT OUR CODE CAN DO:
For the 3 models in paper:
- Solve the models and plot each variable against time
- Vary parameters in all 3 models using a GUI
- Determine stability of steady states for given parameter values
- Carry out sensitivity analysis on parameters
Extensions:
- Provide m files describing our own extensions to the models in paper, now including the impact of treatment
- Solve and plot output for these new models with treatment




FILES

MAIN PROGRAMS

GUIplotter.m
Starts up a GUI that allows output of all 3 models in the paper to be plotted. Selected parameters can be altered using sliders. Some information on stability of steady states is also calculated.

SolveAndPlot * .m 
Function that solves all a model and plots as a function of time: 1) target and infected cell populations on the same axes (linear scale) 2) virus titer (y axis log scale)
Phrase replacing * indicates which model is solved.
Model codes:
(blank)  - solves 3 models in paper
TCL - target cell limited (in paper) 
EM - Extended model (in paper)
EMS - Extended simplified model (in paper)
[See Ronja's section of the report for the following]
Proteasetreatment - splits virus particles into infectious ones and non infectious ones that have been prevented from entering cells by a protease inhibitor treatment. 
EMRTtreatment - viral replication rate is reduced due to a treatment which inhibits Reverse Transcriptase
CD4D - includes side effect where the target cells slowly begin to die as a result of treatment.

PhasePlaneTCL.m 
Solves the Target Cell Limited Model and outputs a phase plane plot of a pair of the model variables e.g. T against V. Takes two inputs, which indicate which variables to plot.

Nullclines.m 
Reproduces the graph in Fig.3 of the paper for the nullclines of the Extended Simplified Model with Quasi Steady State Assumption

paramSweepPlotOurModels.m
Plots graphs showing how final virus titre and final target cell count change as each model parameter is varied. Also outputs to console sensitivity coefficients for all parameters. 
Runs through all three models in paper, in order TCL, EM, EMS, calculating effect of parameter change on final virus titre. Then moves on to the effect on final target cell count.


SUB FUNCTIONS - DERIVATIVES

derivativesTCL.m 
Function that calculates the derivatives for the "Target Cell Limited" model, equations 1-3 in the paper. For use as an input to ode45.

derivativesEM.m 
Function that calculates the derivatives for the "Extended Model", equations 4-7 in the paper. For use as an input to ode45

derivativesEMS.m 
Function that calculates the derivatives for the simplified "Extended Model with Quasi Steady State Assumption", equations 8-10 in the paper. For use as an input to ode45.

derivatives*.m
Derivative functions corresponding to our new models incorporating treatment. All should be suitable for input to ODE45. Phrase replacing * indicates the model being described, see the SolveAndPlot.m readme for a full list.

SUB FUNCTIONS - MEX

ODEmex * .c
Set of functions for speeding up the solution of the models in the paper. * indicates name of model inserted here. Solves using a Runge-Kutta 4th order method. Mex functions are called in a very similar way to ODE45. Used only in the function parameterSweepPlot.m, since this is the only function that was running slow. See this function for example usage.

SUB FUNCTIONS - OTHER

params.m 
Script that generates a struct called "param", containing all the parameters found in all models. Parameters are initialised to sensible values; normally the ones used in the graphs in the paper. For the extended model, three parameters are not given values in the paper. These are marked UNKNOWN in the comments, and have been initialised to values of a reasonable order of magnitude. This script is useful for quickly setting up default parameter values.

paramSweepPlot.m
Contains most of the functionality for ParamSweepPlotOurModels, including varying parameters, calculating sensitivity coefficients and plotting graphs of response to parameter change.

extract*.m
Functions for use in parameter sensitivity analysis, as carried out by paramSweepPlot.m. These take in the solution of a model in the format given by ODE45, and output the value we are testing for sensitivity. The phrase replacing * describes what is output.

EigenvaluesTCL.m
For a given set of parameters, indicates whether the infected steady state of the Target Cell Limited Model is stable. Does this by checking for eigenvalues of the jacobian with positive real part. A test using this function is incorporated into our GUI.

EigenvaluesEMS.m
For given paramaters, calculates whether infective state is stable or not in the Extended Simplified Model with Quasi Steady State Assumption. Plots the stability criterion graph Appendix B on paper, to see if a root and hence a solution exists.

JUNK

1) Any files not described here. May be remaining junk files in the repository due to GitHub malfunctions.

2) *.asv
Any remaining files ending .asv are MATLAB autosaves. They are to be considered junk and deleted from the repository.
