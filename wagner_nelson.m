function [Absorbed]= wagner_nelson(Time,Concentration,ke)

AUC = Concentration;
for i=1:length(AUC)
    AUC(i)=trapz(Time(1:i),Concentration(1:i),1);
end    
Absorbed = Concentration;
for i=1:length(Absorbed)
    Absorbed(i)= ((Concentration(i)/ke)+AUC(i))/AUC(length(AUC));
end 
end