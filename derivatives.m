function [ dy ] = derivatives( y, param )
%Calculates the derivatives for each equation in the model. To put the
%model into a suitable form for MATLAB, each variable in the model has been
%listed as a component in the solution vector y as follows:
%
% V = y(1) = Viral load per epithelial cell
% H = y(2) = Proportion of healthy cells
% I = y(3) = Proportion of infected cells
% M = y(4) = Activated antigen presenting cells per homeostatic level
% F = y(5) = Interferons per homeostatic level of macrophages
% R = y(6) = Proportion of resistant cells
% E = y(7) = Effector cells per homeostatic level
% P = y(8) = Plasma cells per homeostatic level
% A = y(9) = Antibodies per homeostatic level
% S = y(10) = Antigenic distance


%Calculate the number of dead cells. There is no ODE for dead cells, it's
%worked out by subtracting number of live cells from 1 at each step
D = 1-y(2)-y(6)-y(3);


dy(1) = param.gamma_V*y(3)-param.gamma_VA*y(10)*y(9)*y(1)-param.gamma_VH*y(2)*y(1)...
    -param.alpha_V*y(1)-(param.a_V1*y(1))/(1+param.a_V2);

dy(2) = param.b_HD*D*(y(2)+y(6))+param.a_R*y(6)-param.gamma_HV*y(1)*(2)-param.b_HF*y(5)*y(2);

dy(3) = param.gamma_HV*y(1)*y(2)-param.b_IE*y(7)*y(3)-param.a_I*y(3);

dy(4) = (param.b_MD*D+param.b_MV*y(1))*(1-y(4))-param.a_M*y(4);

dy(5) = param.b_F*y(4)+param.c_F*y(3)-param.b_FH*y(2)*y(5)-param.a_F*y(5);

dy(6)= param.b_HF*y(5)*y(2)-param.a_R*y(6);

dy(7) = param.b_EM*y(4)*y(7)-param.b_EI*y(3)*y(7)+param.a_E*(1-y(7));

dy(8) = param.b_PM*y(4)*y(8)+param.a_P*(1-P);

dy(9) = param.b_A*y(8)-param.gamma_AV*y(10)*y(9)*y(1)-param.a_A*y(9);

dy(10) = param.r*y(8)*(1-y(10));

end