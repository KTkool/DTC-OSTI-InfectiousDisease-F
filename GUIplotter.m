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


% Graphical User Interface which plots all three models described by Burg
% et al. Displays stability analysis for TCL and EMS models. Includes the effect of treatment for selected 
% user defined input variables. 

function GUIplotter()

close all

%Define globals for sliders, button, checkbox and text boxes
global sliderp sliderbeta sliderc sliderk slidertheta sliderRTT slidert_st h g model E1 E2 E3 E4 E5 E6 Checker;

%Make a large Figure
gcf=figure('position',[0 0 1600 900], 'name','Parameter Sliders and Instability Analysis', 'NumberTitle', 'off');

%Make large figure colourful
set(gcf, 'color', [0.91 0.8 0.922]);

%Make subplot to hold first plot
h=subplot('position',[0.1 0.4 0.4 0.5]);

%Make subplot to hold second plot
g=subplot('position',[0.55 0.4 0.4 0.5]);


%Make a popup menu to choose which model
model=uicontrol('Style','popupmenu','String','Target Cell Limited|Extended Model|Extended Simplified Model',...
    'Position',[270 290 150 30], 'Callback', @PlotGUI);

%Make push button to reset the values 
uicontrol('Style', 'pushbutton', 'String', 'Reset Values', 'Position', [450 290 100 20], 'Callback', @Resetter);


%Make a checkbox to include the effect of treatment on the solutions
Checker = uicontrol('Style', 'checkbox', 'String', 'Include Drug Treatment', 'Position', [650 290 150 20], 'Callback', @PlotGUI);

%Define a colour for boxes
boxColour=[0.859 0.92 0.8];

%Add a panel onto the GUI around the stability analysis part
uipanel('Title', 'Stability Analysis', 'BackgroundColor', boxColour, ...
    'Position', [0.67 0.05 0.25 0.25]);




%place Eigenvalue labels in GUI
E1 = uicontrol('Style', 'text', 'String', 'E1','BackgroundColor', boxColour, 'Position', [1250 150 70 20]);
E2 = uicontrol('Style', 'text', 'String', 'E2','BackgroundColor', boxColour, 'Position', [1250 100 70 20]);
E3 = uicontrol('Style', 'text', 'String', 'Stable/Unstable','BackgroundColor', boxColour, 'Position', [1350 125 100 20]);
E4 = uicontrol('Style','text','String','Stability Parameter','BackgroundColor', boxColour,'Position',[1150 200 100 40]);
E5 = uicontrol('Style', 'text', 'String', '-', 'BackgroundColor', boxColour, 'Position', [1250 200 60 40]);
E6 = uicontrol('Style', 'text', 'String','-','BackgroundColor', boxColour,...
            'Position', [1350 200 120 50]);
        
%Set labels Eigenvalue 1 & 2
uicontrol('Style', 'text', 'String', 'Eigenvalue 1','BackgroundColor', boxColour, 'Position', [1150 150 80 20]);
uicontrol('Style', 'text', 'String', 'Eigenvalue 2','BackgroundColor', boxColour, 'Position', [1150 100 80 20]);


%Label the p slider
uicontrol('Style','text','String','p: Virus Production Rate','Position',[100 250 100 30]);

%Label the beta slider
uicontrol('Style','text','String','beta: Target Cell Infection Rate Constant','Position',[100 200 100 30]);

%Label the c slider
uicontrol('Style','text','String','c: Virus Clearance Rate','Position',[100 150 100 30]);

%Label the k slider
uicontrol('Style','text','String','k: Depletion Rate of Infected Cells by Effector Cells','Position',[100 100 100 30]);

%Label the theta slider
uicontrol('Style','text','String','theta: Half Maximal Effector Cell Stimulation Threshold','Position',[100 50 100 30]);

%Label the RTT slider
uicontrol('Style','text','String','RTT: Percentage Efficiency of Treatment','Position',[600 250 100 30]);

%Label the t_st slider
uicontrol('Style','text','String','Treatment Start Day','Position',[600 200 100 30]);


%Make the sliders
sliderp=uicontrol('Style','slider','Min',0,'Max',5000,'Position', [250 250 200 30],...
   'Value',1000, 'Callback', @PlotGUI);

sliderbeta=uicontrol('Style','slider','Min',0,'Max',1e-5,'Position', [250 200 200 30],...
     'Value',1.3e-6, 'Callback', @PlotGUI);

sliderc=uicontrol('Style','slider','Min',0,'Max',100,'Position', [250 150 200 30],...
     'Value',3, 'Callback', @PlotGUI);

sliderk=uicontrol('Style','slider','Min',0,'Max',10,'Position', [250 100 200 30],...
     'Value',1,'Callback', @PlotGUI);

slidertheta=uicontrol('Style','slider','Min',0,'Max',10,'Position', [250 50 200 30],...
    'Value',3, 'Callback', @PlotGUI);

sliderRTT=uicontrol('Style','slider','Min',0,'Max',1,'Position', [750 250 200 30],...
    'Value',1, 'Callback', @PlotGUI);

slidert_st=uicontrol('Style','slider','Min',0,'Max',250,'Position', [750 200 200 30],...
    'Value',50, 'Callback', @PlotGUI);
%Call the function to solve for first run through of program
PlotGUI
end
%--------------------------------------------------------------------------------------------------%
%PLOT FUNCTION AND STABILITY%
%-------------------------------------------------------------------------------------------------%

function PlotGUI(hObject, eventdata)

    clear

    global sliderp sliderbeta sliderc sliderk slidertheta sliderRTT slidert_st h g model E1 E2 E3 E4 E5 E6 Checker;
    
%Get param structure from params.m file    
    params;

%Use different model depending on menu choice
    menuchoice = get(model, 'Value');
    
%Get the values from the slider
    param.p= get(sliderp,'Value');
    param.beta= get(sliderbeta,'Value');
    param.c= get(sliderc,'Value');
    param.k= get(sliderk,'Value');
    param.theta= get(slidertheta,'Value');
    param.RTT= get(sliderRTT,'Value'); 
    param.t_st= get(slidert_st,'Value');

% Put Values on the GUI
    uicontrol('Style', 'text', 'String', num2str(param.p), 'Position', [470 255 60 20]);
    uicontrol('Style', 'text', 'String', num2str(param.beta), 'Position', [470 205 60 20]);
    uicontrol('Style', 'text', 'String', num2str(param.c), 'Position', [470 155 60 20]);
    uicontrol('Style', 'text', 'String', num2str(param.k), 'Position', [470 105 60 20]);
    uicontrol('Style', 'text', 'String', num2str(param.theta), 'Position', [470 55 60 20]);
    uicontrol('Style', 'text', 'String', num2str(param.RTT), 'Position', [970 255 60 20]);
    uicontrol('Style', 'text', 'String', num2str(param.t_st), 'Position', [970 205 60 20]);
    
%Get value of the tick box
    Tick = get(Checker, 'Value');
    
%Choose which model to plot and solve 1 = TCL, 2 = EM, 3 = EMS

    if menuchoice ==1
        
        %If no treatment is selected solve normal TCL model
        if Tick == 0
             [t,y]=ode45(@derivativesTCL, [0 250], [1e4, 0, 1e-6 ], [], param);
             
             %Get eigenvalues and R value
             [R, eigVal] = EigenvaluesTCL(param);
             %Begin Stability Analysis for TCL Model
             set(E4, 'String', 'R =');
             set(E5, 'String', num2str(R));
             
            
                
             if(R>1) 
                    %Rename text boxes accordingly depending on value of R
                    set(E6, 'String','R>1: A stable infective state exists');
                    if(real(eigVal(1)) < 0 && real(eigVal(2)) < 0)
                    set(E3, 'String', 'Stable');
                    else
                    set(E3, 'String', 'Unstable');
                    end
             set(E1, 'String', num2str(real(eigVal(1))));
             set(E2, 'String', num2str(real(eigVal(2))));

             else
             set(E6, 'String','R<1: No stable infective state exists');
             set(E1, 'String', 'E1');
             set(E2, 'String', 'E2');
             end
             
        else %If treatment IS selected
            %Taking the end values of no treatment model at t_st, use as
            %input values to the treatment model
            
            set(E1, 'String', 'N/A');
            set(E2, 'String', 'N/A');
            set(E3, 'String', 'Stable/Unstable');
            set(E4, 'String', 'Stability Parameter');
            set(E5, 'String', '-');
            set(E6, 'String','-');
            
            
            [t,y]=ode45(@derivativesTCL, [0 param.t_st], [1e4, 0, 1e-6 ], [], param);
            T0RT= y(end,1);
            I0RT = y(end,2); 
            V0RT = y(end,3);
            
            [t1,m]=ode45(@derivativesTCLRTtreatment_CD4D, [param.t_st 250], [T0RT, I0RT, V0RT], [], param);
        end
        
    elseif menuchoice==2 %EM MODEL
        
        [t,y]=ode45(@derivativesEM, [0 250], [1e4, 0, 1e-6, 10 ], [], param);
        
        %No stability analysis exists for this model so reset boxes to
        %default
        set(E1, 'String', 'N/A');
        set(E2, 'String', 'N/A');
        set(E3, 'String', 'Stable/Unstable');
        set(E4, 'String', 'Stability Parameter');
        set(E5, 'String', '-');
        set(E6, 'String','-');
        if Tick == 1 %If treatment IS selected
            
            [t,y]=ode45(@derivativesEM, [0 param.t_st], [1e4, 0, 1e-6, 10 ], [], param);
            T0RT= y(end,1);
            I0RT = y(end,2); 
            V0RT = y(end,3);
            E0RT = y(end,4);
           
           [t1,m]=ode45(@derivativesEMRTtreatment_CD4D, [param.t_st 250], [T0RT I0RT V0RT E0RT], [], param);
        end
        
    elseif menuchoice ==3 %EMS MODEL
        
        if Tick == 0
            %Solve the ODEs using function derivativesEMS
            [t,y]=ode45(@derivativesEMS, [0 250], [1e4, 0, 1e-6 ], [], param);
            
            %Peform stability analysis
            [sigma, eigVal] = EigenvaluesEMS(param);
            set(E4, 'String', 'sigma=');
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
        else %Treatment IS selected
            
            set(E1, 'String', 'N/A');
            set(E2, 'String', 'N/A');
            set(E3, 'String', 'Stable/Unstable');
            set(E4, 'String', 'Stability Parameter');
            set(E5, 'String', '-');
            set(E6, 'String','-');
            
            [t,y]=ode45(@derivativesEMS, [0 param.t_st], [1e4, 0, 1e-6 ], [], param);
            T0RT= y(end,1);
            I0RT = y(end,2); 
            V0RT = y(end,3);
            
            [t1,m]=ode45(@derivativesEMSRTtreatment_CD4D, [param.t_st 250], [T0RT I0RT V0RT], [], param);  
        end
end
    
%--------------------------------------------------------------------------------------------------%
%PLOTTING RESULTS%
%-------------------------------------------------------------------------------------------------% 

if Tick == 0 %If treatment IS NOT selected
    plot(h, t, y(:,1), 'r', t, y(:,2), 'g', 'LineWidth', 2);
    xlabel(h, 'time(days)');
    ylabel(h, 'cell count/ml');
    title(h, '\fontsize{16}Target and Infected Cells');
    legend(h, 'targets', 'infected') ;
    
    semilogy(g, t, y(:,3), 'k');
    xlabel(g, 'time(days)');
    ylabel(g, 'virus titer');
    title(g, '\fontsize{16}Virus Titer');
else
    
    plot(h, t, y(:,1), 'r', t, y(:,2), 'g', t1, m(:,1), 'b', t1, m(:,2), 'm', 'LineWidth', 2);
    xlabel(h, 'time(days)');
    ylabel(h, 'cell count/ml');
    title(h, '\fontsize{16}Target and Infected Cells');
    legend(h, 'targets', 'infected', 'targets with treatment', 'infected with treatment');
    
   
    semilogy(g, t, y(:,3), 'k', t1, m(:,3), 'b' ); 
    xlabel(g, 'time(days)');
    ylabel(g, 'virus titer');
    title(g, '\fontsize{16}Virus Titer');

end
end

%--------------------------------------------------------------------------------------------------%
%Reset button
%-------------------------------------------------------------------------------------------------%


function [] = Resetter(hObject, eventdata)
   params;
   global sliderp sliderbeta sliderc sliderk slidertheta sliderRTT slidert_st;
   
   set(sliderp, 'Value', param.p);
   set(sliderbeta, 'Value', param.beta);
   set(sliderc, 'Value', param.c);
   set(sliderk, 'Value', param.k);
   set(slidertheta, 'Value', param.theta);
   set(sliderRTT, 'Value', param.RTT);
   set(slidert_st, 'Value', param.t_st);
   PlotGUI;
end
   
           
       
       
        
