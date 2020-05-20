function [Auc_ob,Auc_cal,Cmax_ob,Cmax_cal,pe_auc,pe_Cmax]=Compare_plasma_conc(time_ob,conc_ob,time_cal,conc_cal)
Auc_ob=trapz(time_ob,conc_ob);
Auc_cal=trapz(time_cal,conc_cal);
Cmax_ob=max(conc_ob);
Cmax_cal=max(conc_cal);
pe_auc=((Auc_ob-Auc_cal)/Auc_ob)*100;
pe_Cmax=((Cmax_ob-Cmax_cal)/Cmax_ob)*100;
colour=rand(1,3);
plot(time_ob, conc_ob, 'o','color',colour,'displayname','observed')
hold on,
plot(time_cal, conc_cal,'color',colour,'displayname','calculated')
legend('location','ne')
title('Plasma profile')
xlabel('Time')
ylabel('Concentration')
end