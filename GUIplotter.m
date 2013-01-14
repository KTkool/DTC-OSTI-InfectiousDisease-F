%{
Copyright 2013 Lucy Hutchinson, Adam Berrington
	
This file is part of DTC-OSTI-InfectiousDisease-F.

DTC-OSTI-InfectiousDisease-F is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

DTC-OSTI-InfectiousDisease-F is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with DTC-OSTI-InfectiousDisease-F. If not, see <http://www.gnu.org/licenses/>.
%}

% Graphical User Interface to vary input parameters p, beta, c and k of "Simplified extended
% model" and display the effect on the stability

function GUIplotter()

close all

global sliderp sliderbeta sliderc sliderk slidertheta h g model E1 E2 E3 E4 E5 E6;

%Make a large Figure
gcf=figure('position',[0 0 1600 900], 'name','Parameter Sliders and Instability Analysis', 'NumberTitle', 'off');

set(gcf, 'color', [0.91 0.8 0.922]);

%Make subplot to hold first plot
h=subplot('position',[0.1 0.4 0.4 0.5]);

%Make subplot to hold second plot
g=subplot('position',[0.55 0.4 0.4 0.5]);

%Make a popup menu to choose which model
model=uicontrol('Style','popupmenu','String','Target Cell Limited|Extended Model|Extended Simplified Model',...
    'Position',[770 290 150 30], 'Callback', @PlotGUI);

%Place a box around the stability analysis part
boxColour=[0.859 0.92 0.8];

uipanel('Title', 'Stability Analysis', 'BackgroundColor', boxColour, ...
    'Position', [0.67 0.05 0.25 0.25])
%place Eigenvalue labels in GUI
E1 = uicontrol('Style', 'text', 'String', 'E1','BackgroundColor', boxColour, 'Position', [1250 150 60 20]);
E2 = uicontrol('Style', 'text', 'String', 'E2','BackgroundColor', boxColour, 'Position', [1250 100 60 20]);
E3 = uicontrol('Style', 'text', 'String', 'Stable/Unstable','BackgroundColor', boxColour, 'Position', [1350 125 100 20]);
E4 = uicontrol('Style','text','String','Stability Parameter','BackgroundColor', boxColour,'Position',[1150 200 100 20]);
E5 = uicontrol('Style', 'text', 'String', '-', 'BackgroundColor', boxColour, 'Position', [1250 200 60 20]);
E6 = uicontrol('Style', 'text', 'String','-','BackgroundColor', boxColour,...
            'Position', [1350 200 100 30]);
uicontrol('Style', 'text', 'String', 'Eigenvalue 1','BackgroundColor', boxColour, 'Position', [1150 150 70 20]);
uicontrol('Style', 'text', 'String', 'Eigenvalue 2','BackgroundColor', boxColour, 'Position', [1150 100 70 20]);
%Label the p slider
uicontrol('Style','text','String','p: Virus Production Rate','Position',[600 250 100 30]);

%Label the beta slider
uicontrol('Style','text','String','beta: Target Cell Infection Rate Constant','Position',[600 200 100 30]);

%Label the c slider
uicontrol('Style','text','String','c: Virus Clearance Rate','Position',[600 150 100 30]);

%Label the k slider
uicontrol('Style','text','String','k: Depletion Rate of Infected Cells by Effector Cells','Position',[600 100 100 30]);

%Label the theta slider
uicontrol('Style','text','String','theta: Half Maximal Effector Cell Stimulation Threshold','Position',[600 50 100 30]);


%Make the sliders
sliderp=uicontrol('Style','slider','Min',0,'Max',5000,'Position', [750 250 200 30],...
   'Value',1000, 'Callback', @PlotGUI);

sliderbeta=uicontrol('Style','slider','Min',0,'Max',1e-5,'Position', [750 200 200 30],...
     'Value',1.3e-6, 'Callback', @PlotGUI);

sliderc=uicontrol('Style','slider','Min',0,'Max',100,'Position', [750 150 200 30],...
     'Value',3, 'Callback', @PlotGUI);

sliderk=uicontrol('Style','slider','Min',0,'Max',10,'Position', [750 100 200 30],...
     'Value',1,'Callback', @PlotGUI);

slidertheta=uicontrol('Style','slider','Min',0,'Max',10,'Position', [750 50 200 30],...
    'Value',3, 'Callback', @PlotGUI);

PlotGUI
% Call the function to solve

function PlotGUI(hObject, eventdata)

clear

global sliderp sliderbeta sliderc sliderk slidertheta h g model E1 E2 E3 E4 E5 E6;

params;

%Use different model depending on menu choice
menuchoice = get(model, 'Value');

%Get value for parameter p from the slider
param.p= get(sliderp,'Value');

%Get value for parameter beta from the slider
param.beta= get(sliderbeta,'Value');

%Get value for parameter c from the slider
param.c= get(sliderc,'Value');

%Get value for parameter k from the slider
param.k= get(sliderk,'Value');

%Get value for parameter theta from the slider
param.theta= get(slidertheta,'Value');

% Put Value of p on the GUI
uicontrol('Style', 'text', 'String', num2str(param.p), 'Position', [970 255 60 20]);

% Put Value of beta on the GUI
uicontrol('Style', 'text', 'String', num2str(param.beta), 'Position', [970 205 60 20]);

% Put Value of c on the GUI
uicontrol('Style', 'text', 'String', num2str(param.c), 'Position', [970 155 60 20]);

% Put Value of k on the GUI
uicontrol('Style', 'text', 'String', num2str(param.k), 'Position', [970 105 60 20]);

% Put Value of theta on the GUI
uicontrol('Style', 'text', 'String', num2str(param.theta), 'Position', [970 55 60 20]);

%Choose which model to plot and solve, call appropriate Eigenvalue analysis
if menuchoice ==1
    set(E4, 'String', 'R =');
    [t,y]=ode45(@derivativesTCL, [0 250], [1e4, 0, 1e-6 ], [], param);
    [R, eigVal] = EigenvaluesTCL(param);
    
    %label the stability criteria parameter
    
    set(E5, 'String', num2str(R));
    if(R>1) 
        set(E6, 'String','R>1: A stable infective state exists');
        if(real(eigVal(1,1)) < 0 && real(eigVal(2,2)) < 0)
        set(E3, 'String', 'Stable');
        else
        set(E3, 'String', 'Unstable');
        end
        set(E1, 'String', num2str(real(eigVal(1,1))));
        set(E2, 'String', num2str(real(eigVal(2,2))));

    else
        set(E6, 'String','R<1: No stable infective state exists');
        set(E1, 'String', 'E1');
        set(E2, 'String', 'E2');
    end
    
elseif menuchoice==2
    set(E1, 'String', 'N/A');
    set(E2, 'String', 'N/A');
    set(E3, 'String', 'Stable/Unstable');
    set(E4, 'String', 'Stability Parameter');
    set(E5, 'String', '-');
    set(E6, 'String','-');
    [t,y]=ode45(@derivativesEM, [0 250], [1e4, 0, 1e-6, 10 ], [], param);
    
elseif menuchoice ==3
%Solve the ODEs using function derivativesEMS
    set(E4, 'String', 'sigma=');
    [t,y]=ode45(@derivativesEMS, [0 250], [1e4, 0, 1e-6 ], [], param);
    [sigma, eigVal] = EigenvalueQS(param);
    
    set(E5, 'String', num2str(sigma));
    
    if(sigma>1) 
        set(E6, 'String','sigma>1: A stable infective state exists');
        if(real(eigVal(1)) < 0 && real(eigVal(2)) < 0)
        set(E3, 'String', 'Stable');
        else
        set(E3, 'String', 'Unstable');
        end
        set(E1, 'String', num2str(real(eigVal(1))));
        set(E2, 'String', num2str(real(eigVal(2))));

    else
        set(E6, 'String','sigma<1: No stable infective state exists');
        set(E1, 'String', 'E1');
        set(E2, 'String', 'E2');
    end
    
end

plot(h, t, y(:,1), 'r', t, y(:,2), 'g', 'LineWidth', 2);
xlabel(h, 'time(days)')
ylabel(h, 'cell count/ml')
title(h, '\fontsize{16}Target and Infected Cells')
legend(h, 'targets', 'infected') 

semilogy(g, t, y(:,3), 'k');
xlabel(g, 'time(days)')
ylabel(g, 'virus titer')
title(g, '\fontsize{16}Virus Titer')