% Graphical User Interface to vary input parameters p, beta, c and k of "Simplified extended
% model" and display the effect on the stability

function GUIderivativesEMS()

close all

global sliderp sliderbeta sliderc sliderk h g model;

%Make a large Figure
figure('position',[0 0 1600 900], 'name','Simplified Extended Model', 'NumberTitle', 'off');

%Make subplot to hold first plot
h=subplot('position',[0.1 0.4 0.4 0.5]);

%Make subplot to hold second plot
g=subplot('position',[0.55 0.4 0.4 0.5]);

%Make a popup menu to choose which model
model=uicontrol('Style','popupmenu','String','Target Cell Limited|Extended Model|Extended Simplified Model',...
    'Position',[50 50 150 30], 'Callback', @PlotGUI);

%Label for stability analysis 
uicontrol('Style','text','String','Stability Analysis','Position',[1250 250 100 30]);

%Label the p slider
uicontrol('Style','text','String','p: Virus Production Rate','Position',[600 200 100 30]);

%Label the beta slider
uicontrol('Style','text','String','beta: Target Cell Infection Rate Constant','Position',[600 150 100 30]);

%Label the c slider
uicontrol('Style','text','String','c: Virus Clearance Rate','Position',[600 100 100 30]);

%Label the k slider
uicontrol('Style','text','String','k: Depletion Rate of Infected Cells by Effector Cells','Position',[600 50 100 30]);


%Make the sliders
sliderp=uicontrol('Style','slider','Min',0,'Max',5000,'Position', [750 200 200 30],...
    'Callback', @PlotGUI);

sliderbeta=uicontrol('Style','slider','Min',0,'Max',1e-5,'Position', [750 150 200 30],...
    'Callback', @PlotGUI);

sliderc=uicontrol('Style','slider','Min',0,'Max',100,'Position', [750 100 200 30],...
    'Callback', @PlotGUI);

sliderk=uicontrol('Style','slider','Min',0,'Max',10,'Position', [750 50 200 30],...
    'Callback', @PlotGUI);

% Call the function to solve

function PlotGUI(hObject, eventdata)

clear

global sliderp sliderbeta sliderc sliderk h g model;

params;

%Use different model depending on menu choice
menuchoice = get(model, 'Value')

%Get value for parameter p from the slider
param.p= get(sliderp,'Value');

%Get value for parameter beta from the slider
param.beta= get(sliderbeta,'Value');

%Get value for parameter c from the slider
param.c= get(sliderc,'Value');

%Get value for parameter k from the slider
param.k= get(sliderk,'Value');

% Put Value of p on the GUI
uicontrol('Style', 'text', 'String', num2str(param.p), 'Position', [1000 200 60 20]);

% Put Value of beta on the GUI
uicontrol('Style', 'text', 'String', num2str(param.beta), 'Position', [1000 150 60 20]);

% Put Value of p on the GUI
uicontrol('Style', 'text', 'String', num2str(param.c), 'Position', [1000 100 60 20]);

% Put Value of p on the GUI
uicontrol('Style', 'text', 'String', num2str(param.k), 'Position', [1000 50 60 20]);

%Choose which model to plot and solve, call appropriate Eigenvalue analysis
if menuchoice ==1
    uicontrol('Style','text','String','R=','Position',[1250 200 60 20]);
    [t,y]=ode45(@derivativesTCL, [0 250], [1e4, 0, 1e-6 ], [], param);
    [R, eigVal] = EigenvaluesTCL(param);
    
    %label the stability criteria parameter
    uicontrol('Style', 'text', 'String', num2str(eigVal(2,2)), 'Position', [1300 150 60 20]);
    uicontrol('Style', 'text', 'String', num2str(eigVal(1,1)), 'Position', [1300 100 60 20]);
    
    uicontrol('Style', 'text', 'String', num2str(R), 'Position', [1300 200 60 20]);
    if(R>1) 
        uicontrol('Style', 'text', 'String','R>1: A stable infective state exists',...
            'Position', [1400 200 100 30]);
    else
        uicontrol('Style', 'text', 'String','R<1: No stable infective state exists',...
            'Position', [1400 200 100 30]);
    end
    %checks to see if is a stable paramter set
    if(real(eigVal(1,1)) < 0 && real(eigVal(2,2)) < 0)
        uicontrol('Style', 'text', 'String', 'Stable', 'Position', [1400 125 100 20]);
    else
         uicontrol('Style', 'text', 'String', 'Unstable', 'Position', [1400 125 100 20]);
    end
    
elseif menuchoice==2
    [t,y]=ode45(@derivativesEM, [0 250], [1e4, 0, 1e-6, 10 ], [], param);
    
elseif menuchoice ==3
%Solve the ODEs using function derivativesEMS
    [t,y]=ode45(@derivativesEMS, [0 250], [1e4, 0, 1e-6 ], [], param);

end

plot(h, t, y(:,1), 'r', t, y(:,2), 'g');
xlabel(h, 'time(days)')
ylabel(h, 'cell count/ml')
title(h, 'Extended Simplified Model')
legend(h, 'targets', 'infected') 

semilogy(g, t, y(:,3), 'k');
xlabel(g, 'time(days)')
ylabel(g, 'virus titer')
