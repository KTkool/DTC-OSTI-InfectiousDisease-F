% a run

params;
treatment=alternatingDrugs(1000,50);
[t,y]=processTreatment(treatment,[1000,10,0.0001,0.1,0.1],param);
subplot(2,2,1)
plot(t,y(:,1))
subplot(2,2,2)
plot(t,y(:,2))
subplot(2,2,3)
plot(t,y(:,4))
subplot(2,2,4)
plot(t,y(:,5))
