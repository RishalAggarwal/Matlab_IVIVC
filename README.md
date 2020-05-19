# Matlab_IVIVC
A tutorial/workflow and code for performing In Vitro - In Vivo Correlation for formulation scientists using matlab
Contents:
1) Importing Data
2) In Vitro curve fitting
3) Model Based Convolution Deconvolution 
4) Point Area Convolution and Deconvolution
5) Plotting and comparing results

## Importing Data

Matlab provides an in-built tool for importing data from csv and excel sheets. More about it in this [link](https://in.mathworks.com/help/matlab/ref/importtool.html). 
For this workflow we mainly import the data in the form of column vectors. A representative screenshot for the same is give below.

![alt text](https://github.com/RishalAggarwal/Matlab_IVIVC/blob/master/images/import_data.jpg)

## In Vitro Curve Fitting

Matlab provides a Curve Fitting tool ([link](https://in.mathworks.com/help/curvefit/curve-fitting.html)) that can be used to fit cumulative distributions. It also has a section to fill in custom equations like the weibull cumulative equation in the manner below:

![alt text](https://github.com/RishalAggarwal/Matlab_IVIVC/blob/master/images/in_vitro.jpg)

The fit curve can then be imported back in to the workspace. From the drop down menu: Fit -> Save to Workspace -> fill in the name of the curve for "save fit to Matlab object named" and the name by which you want to save the metrics of the curve fit for "save goodness of fit to MATLAB struct named". 

In my case I've filled them in as In_vitro_curve and In_vitro_goodness. I can then review my results and parameters by entering the names anytime in the command window.

```
>> In_vitro_curve

In_vitro_curve = 

     General model:
     In_vitro(x) = 1-exp(-(x/a)^b)
     Coefficients (with 95% confidence bounds):
       a =       7.628  (6.996, 8.26)
       b =       0.838  (0.7456, 0.9304)

>> In_vitro_goodness

In_vitro_goodness = 

  struct with fields:

           sse: 0.0116
       rsquare: 0.9877
           dfe: 11
    adjrsquare: 0.9866
          rmse: 0.0325
          
```
