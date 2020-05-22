# Matlab_IVIVC
A tutorial/workflow and code for performing In Vitro - In Vivo Correlation for formulation scientists using matlab

Contents:
1) Importing Data
2) In Vitro curve fitting
3) Model Based Convolution Deconvolution 
4) Point Area/Numerical Convolution and Deconvolution
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
I can also use the curve object to get values for certain data points.

```
>> In_vitro_curve(30)

ans =

    0.9572 
```

##  Model Based Convolution Deconvolution 

Currently only Wagner Nelson is implemented in this workflow. It require a time as well as a plasma concentration column vector which can easily be imported from excel as shown before. In addition it also requires elimination rate constant to be 'ke' to be calculated already. Make sure that the Time and Concentration column vectors begin with a data point for '0' time. If it does not, then the data point can easily be added in the following maner:

```
Time=[0;TIme];
Concentration=[0;Concentration];
```
To generate the in vitro drug released values for the plasma concentration time points we can use the In_vitro_curve as before.
```
>>released=In_vitro_curve(Time);
```
The cumulative fraction absorbed can be got by running:

``` 
>>Absorbed=wagner_nelson(Time,Concentration,ke)
```

To get the calculated plasma profile we first need to get the estimated absorption constant. We can get this by using the curve fitting app again. Just plot the Absorbed values on y axis and time values on x axis and fill in this custom equation which assumes a first order absorption process:

```
1-exp(-a*x)
```

The estimated value of 'a' will be the absorption rate constant. The dose, absorption rate constant and elimination rate constant can be used to simulate a curve using the simbiology and simbiology model app in a similar manner as shown in the video [here](https://www.mathworks.com/videos/simulating-a-model-in-simbiology-117245.html).

For evaluating the IVIVC model two functions are provided. Plot_line function plots a regression line between the fraction drug absorbed and fraction drug released. It also requires a label to call the line plot. It returns the RMSE, the R2 and prints the line equation. A representative example is given below.

```
>>[RMSE,R2]=plot_line(absorbed,released,'wagner nelson')
Regression line (y = 1.14*x + -0.12)RMSE: 0.06 | R2: 0.99

RMSE =

    0.0592


R2 =

    0.9867

```

![alt text](https://github.com/RishalAggarwal/Matlab_IVIVC/blob/master/images/Wagner_nelson_img.jpg)

The compare_plasma_conc function returns the observed and calculated AUC and Cmax as well as the percentage error between the observed and calculated values.

```
>> [Auc_ob,Auc_cal,Cmax_ob,Cmax_cal,pe_auc,pe_Cmax]=Compare_plasma_conc(Time,Concentration,time_calculated,conc_calculated)

Auc_ob =

    6.7688


Auc_cal =

    5.4519


Cmax_ob =

    0.6210


Cmax_cal =

    0.4309


pe_auc =

   19.4548


pe_Cmax =

   30.6163
   ```

![alt text](https://github.com/RishalAggarwal/Matlab_IVIVC/blob/master/images/plasma_profile.jpg)

Workflow for larger compartment models are yet to be implemented. However something that may be of use is the method of fitting multi-compartment PK models to plasma profiles using the simbiology app in a manner shown [here](https://www.mathworks.com/help/simbio/ug/calculate-NCA-and-estimate-PKPD-parameters.html) in addition I've also written a function that returns the cumulative fraction of drug absorbed given the time and absorption rate constant.

```
>>absorbed=fraction_absorbed(Time,ka)
```


