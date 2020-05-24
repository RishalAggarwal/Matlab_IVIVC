function [absorbed,erro]=numerical_deconv(UIR,Conc_ob)
UIR_point=UIR;
for i=2:length(UIR)
 UIR_point(i)=(UIR(i)+UIR(i-1))/2;
end
absorbed_point=zeros(1,length(Conc_ob)).';
absorbed_point(1:end)=0.5;
[absorbed_point,erro]=dg_deconv(UIR_point,Conc_ob,absorbed_point,0,0.0001);
absorbed=absorbed_point;
for i=2:length(absorbed)
absorbed(i)=absorbed(i)+absorbed(i-1);
end