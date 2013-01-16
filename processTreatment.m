function [t,y] = processTreatment(treatment, initialConditions, param)
%Function that takes a treatment and returns the effect of this treatment
%on the patient.

%Treatment is a structure, with the following parameters
% treatment.stepLengths : A vector indicating for how long some drug
% combination should be taken
% treatment.drug1 : A vector of size treatment.stepLengths indicating
% whether drug1 should be taken during this phase of the treatment
% treatment.drug2 : cf. drug1

y = [initialConditions];
t = [0];
for i=1:length(treatment.stepLengths)
    [t1,y1] = SolveTCLCombinationDrugResistance( param, treatment.stepLengths(i), y(end,:), treatment.drug1(i), treatment.drug2(i));
    t = [t ; t1 + t(end)];
    y = [y ; y1];
end;

end