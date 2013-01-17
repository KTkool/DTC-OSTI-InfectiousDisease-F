% a run

params;
%treatment=alternatingDrugs(2000,50);
treatment.stepLengths = [100 1000];
treatment.drug1 = [0 0];
treatment.drug2 = [0 0];
[t,y]=processTreatment(treatment,[1000,10,0.0001,0.1,0.1],param);
subplot(2,2,1)
plot(t,y(:,1))
subplot(2,2,2)
plot(t,y(:,2))
subplot(2,2,3)
plot(t,y(:,4))
subplot(2,2,4)
plot(t,y(:,5))
