% code inspired from that written by Petter Stefansson
% (https://in.mathworks.com/matlabcentral/answers/478999-how-to-show-r-square-correlation-and-rmse-on-a-scatterplot)
function [RMSE,R_squared]=plot_line(Fraction_absorbed,Fraction_released)
plot(Fraction_released, Fraction_absorbed, 'o','displayname','Scatterplot')
title('Correlation')
xlabel('In Vitro Release')
ylabel('In Vivo Absorption')
% Fit linear regression line with OLS.
b = [ones(size(Fraction_released,1),1) Fraction_released]\Fraction_absorbed;
% Use estimated slope and intercept to create regression line.
RegressionLine = [ones(size(Fraction_released,1),1) Fraction_released]*b;
% Plot it in the scatter plot and show equation.
hold on,
plot(Fraction_released,RegressionLine,'displayname',sprintf('Regression line (y = %0.2f*x + %0.2f)',b(2),b(1)))
legend('location','nw')
% RMSE between regression line and y
RMSE = sqrt(mean((Fraction_absorbed-RegressionLine).^2));
% R2 between regression line and y
SS_X = sum((RegressionLine-mean(RegressionLine)).^2);
SS_Y = sum((Fraction_absorbed-mean(Fraction_absorbed)).^2);
SS_XY = sum((RegressionLine-mean(RegressionLine)).*(Fraction_absorbed-mean(Fraction_absorbed)));
R_squared = SS_XY/sqrt(SS_X*SS_Y);
fprintf('RMSE: %0.2f | R2: %0.2f\n',RMSE,R_squared)
end