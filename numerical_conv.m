function[conc_cal]= numerical_conv(input,UIR)
UIR_point=UIR;
for i=2:length(UIR)
 UIR_point(i)=(UIR(i)+UIR(i-1))/2;
end
input_point=input;
for i=2:length(input)
input_point(i)=input(i)-input(i-1);
end
conc_cal=conv(input_point,UIR_point);
conc_cal=conc_cal(1:length(input));
end
