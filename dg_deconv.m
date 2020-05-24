% Code inspired from: Jorel Ximes (2020). Descent Gradient 1D Deconvolution 
%(https://www.mathworks.com/matlabcentral/fileexchange/36861-descent-gradient-1d-deconvolution)
% MATLAB Central File Exchange. Retrieved May 21, 2020.

% Deconvolves H from the form X * H = Y 
% Uses Simulated Annealing on step reduction
% Uses Descent Gradient on each coefficient of H
% Algorithm stops when msdEnd or minstep is reached 
%
% Inputs
%   Y -> must have size of length(X)+floor(length(H)/2)
%   H -> initial guess. Can be zeros or random.¨
%   X 
%   msdEnd -> Desired final Root Mean Square Deviation error from deconvoluted Y  
%   minstep -> Desired final minimum step size of H coefficients
% 
% Outputs
%   H -> deconvoluted H
function [x,erro]=dg_deconv(y,h,x,msdEnd,minstep)
stepinic=1-msdEnd;
step=max(h)/max(y)+max(x);
again=1;
count=0;
aumentapassop=0;
aumentapassom=0;
while (again)
    count=count+1;
    liststeps(count)=step;
    t=conv(y,x);
    t=t(1:length(x));
    erro=sqrt(sum((h-t).^2)/length(h));
    errocount(count)=erro;
    
    for i=1:length(x)
        x(i)=x(i)+step;
        t=conv(y,x);
        t=t(1:length(x));
        errmais=sqrt(sum((h-t).^2)/length(h));
        errosmais(i)=errmais-erro;
        x(i)=x(i)-step;
    end
    
    for i=1:length(x)
        x(i)=x(i)-step;
        t=conv(y,x);
        t=t(1:length(x));
        errmenos=sqrt(sum((h-t).^2)/length(h));
        errosmenos(i)=errmenos-erro;
        x(i)=x(i)+step;
    end
    [valorp,indicep]=min(errosmais);
    [valorm,indicem]=min(errosmenos);
    
    %--------------------------------
    if (valorp<0 || valorm<0)
%         METHOD1
%         %-------------
%         if (valorp<valorm)
%             x(indicep)=x(indicep)+step;
%         else 
%             x(indicem)=x(indicem)-step;
%         end  
%         %-------------
        %METHOD2
        %-------------
        soma=0;
        for i=1:length(x)
            if (errosmenos(i)<0)
                soma=soma+errosmenos(i);
            end
            if (errosmais(i)<0)
                soma=soma+errosmais(i);
            end
        end
        for i=1:length(x)
            if (errosmenos(i)<0)        
                x(i)=x(i)-step*errosmenos(i)/soma;
            end
            if (errosmais(i)<0)
                x(i)=x(i)+step*errosmais(i)/soma;
            end
        end
        %-------------
        
        if (aumentapassop>=0)
            stepinic=((1-minstep)+stepinic)/2;
        end
        if (aumentapassop>0)
            step=step/stepinic;
        end
        aumentapassop=aumentapassop+1;
        aumentapassom=0;
      
    else
        step=step*stepinic;
        if (aumentapassom)
            stepinic=(stepinic+0.5)/2;    
        else
            aumentapassom=1;
        end
        aumentapassop=0;
        if (erro<msdEnd || step<minstep) 
            again=0;
        end;
    end; 
    %--------------------------------
end;