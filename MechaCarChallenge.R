#Deliverable 1: Linear Regression to Predict MPG
#Perform multiple linear regression analysis to identify which variables in the dataset predict the mpg of MechaCar prototypes
#setwd("~/bootcamp/module15-R/MechaCar_Statistical_Analysis")
install.packages("tidyverse")
#install.packages("dplyr")
#library(dplyr)
library(tidyverse)
MechaCar_data <- read.csv('MechaCar_mpg.csv', check.names=F,stringsAsFactors = F) #import dataset
head(MechaCar_data)
#head(mtcars)
#?lm()
lm(mpg ~ vehicle_length + vehicle_weight + spoiler_angle + ground_clearance + AWD, data = MechaCar_data) #generate multiple linear regression model
      #Call:
      #  lm(formula = mpg ~ vehicle_length + vehicle_weight + spoiler_angle + 
      #       ground_clearance + AWD, data = MechaCar_data)
      
      #Coefficients:
      #  (Intercept)    vehicle_length    vehicle_weight     spoiler_angle  ground_clearance               AWD  
      #-1.040e+02         6.267e+00         1.245e-03         6.877e-02         3.546e+00        -3.411e+00  
      #Multiple Linear Regression model:
      #mpg = (6.267e+00)vehicle_length + (1.245e-03)vehicle_weight + (6.877e-02)spoiler_angle + (3.546e+00)ground_clearance + (-3.411e+00)AWD + (-1.040e+02)
summary(lm(mpg ~ vehicle_length + vehicle_weight + spoiler_angle + ground_clearance + AWD, data = MechaCar_data)) #generate summary statistics
      #Call:
      #  lm(formula = mpg ~ vehicle_length + vehicle_weight + spoiler_angle + 
      #       ground_clearance + AWD, data = MechaCar_data)
      
      #Residuals:
      #  Min       1Q   Median       3Q      Max 
      #-19.4701  -4.4994  -0.0692   5.4433  18.5849 
      
      #Coefficients:
      #  Estimate Std. Error t value Pr(>|t|)    
      #(Intercept)      -1.040e+02  1.585e+01  -6.559 5.08e-08 ***
      #  vehicle_length    6.267e+00  6.553e-01   9.563 2.60e-12 ***
      #  vehicle_weight    1.245e-03  6.890e-04   1.807   0.0776 .  
      #spoiler_angle     6.877e-02  6.653e-02   1.034   0.3069    
      #ground_clearance  3.546e+00  5.412e-01   6.551 5.21e-08 ***
      #  AWD              -3.411e+00  2.535e+00  -1.346   0.1852    
      #---
      #  Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
      
      #Residual standard error: 8.774 on 44 degrees of freedom
      #Multiple R-squared:  0.7149,	Adjusted R-squared:  0.6825 
      #F-statistic: 22.07 on 5 and 44 DF,  p-value: 5.35e-11

  #Multiple R-squared:  0.7149,	
  #p-value: 5.35e-11
  #According to our results, vehicle_length(2.60e-12 ***) and ground_clearance (5.21e-08 ***) (as well as intercept,5.08e-08 ***) are statistically unlikely 
  # to provide random amounts of variance to the linear model. In other words the vehicle_length and ground_clearance have a significant impact on mpg.

lm(mpg ~ vehicle_length, data = MechaCar_data)
    #Call:
    #  lm(formula = mpg ~ vehicle_length, data = MechaCar_data)
    
    #Coefficients:
    #  (Intercept)  vehicle_length  
    #-25.062           4.673  

lm(mpg ~ ground_clearance, data = MechaCar_data)
      #Call:
      #  lm(formula = mpg ~ ground_clearance, data = MechaCar_data)
      
      #Coefficients:
      #  (Intercept)  ground_clearance  
      #19.418             2.022 

  ?ggplot()
plt <- ggplot(MechaCar_data,aes(x=vehicle_length,y=mpg)) #import dataset into ggplot2
plt + geom_point() + geom_line(aes(y=mpg), color = "red") #plot scatter and linear model

  #mpg =  (4.673)vehicle_length + -25.062
plt <- ggplot(MechaCar_data,aes(x=ground_clearance,y=mpg)) #import dataset into ggplot2
plt + geom_point() + geom_line(aes(y=mpg), color = "red") #plot scatter and linear model
  #mpg = 2.022ground_clearance + 19.418
plt <- ggplot(MechaCar_data,aes(x=spoiler_angle,y=mpg)) #showing unpredictable
plt + geom_point() + geom_line(aes(y=mpg), color = "red") #plot scatter and linear model

#Which variables/coefficients provided a non-random amount of variance to the mpg values in the dataset?

#Is the slope of the linear model considered to be zero? Why or why not?

#Does this linear model predict mpg of MechaCar prototypes effectively? Why or why not?

  
  
#Deliverable 2: Summary Statistics on Suspension Coils
#Collect summary statistics on the pounds per square inch (PSI) of the suspension coils from the manufacturing lots
suspension <- read.csv('Suspension_Coil.csv', check.names=F,stringsAsFactors = F) #import dataset
head(suspension)
?summarize()
total_summary <- suspension %>% summarize(Mean=mean(PSI),Median=median(PSI), Variance=var(PSI), SD=sd(PSI), .groups = 'keep') #create summary table with multiple columns
lot_summary <- suspension %>% group_by(Manufacturing_Lot) %>% summarize(Mean=mean(PSI),Median=median(PSI), Variance=var(PSI), SD=sd(PSI), .groups = 'keep') #create summary table with multiple columns


#Deliverable 3: T-Test on Suspension Coils
#Run t-tests to determine if the manufacturing lots are statistically different from the mean population
?t.test()

lot_1 <- suspension %>% filter(Manufacturing_Lot=='Lot1') #
lot_2 <- suspension %>% filter(Manufacturing_Lot=='Lot2') #
lot_3 <- suspension %>% filter(Manufacturing_Lot=='Lot3') #

t.test(suspension$PSI, mu=1500) #compare entire lots 
    #One Sample t-test
    
    #data:  suspension$PSI
    #t = -1.8931, df = 149, p-value = 0.06028
    #alternative hypothesis: true mean is not equal to 1500
    #95 percent confidence interval:
    #  1497.507 1500.053
    #sample estimates:
    #  mean of x 
    #1498.78 
    # our p-value is above our significance level, Our Mean is below industry average, not good!

t.test(lot_1$PSI, mu=1500) #compare sample versus population means
    #One Sample t-test
    
    #data:  lot_1$PSI
    #t = 0, df = 49, p-value = 1
    #alternative hypothesis: true mean is not equal to 1500
    #95 percent confidence interval:
    #  1499.719 1500.281
    #sample estimates:
    #  mean of x 
    #1500 
    # our p-value is above our significance level, actually 1 hence perfect sample with our mean at industry average !
t.test(lot_2$PSI, mu=1500) #compare sample versus population means
    #One Sample t-test
    
    #data:  lot_2$PSI
    #t = 0.51745, df = 49, p-value = 0.6072
    #alternative hypothesis: true mean is not equal to 1500
    #95 percent confidence interval:
    #  1499.423 1500.977
    #sample estimates:
    #  mean of x 
    #1500.2
    # our p-value is above our significance level, p-value = 0.6072, our mean is above industry average!
t.test(lot_3$PSI, mu=1500) #compare sample versus population means
    #One Sample t-test
    
    #data:  lot_3$PSI
    #t = -2.0916, df = 49, p-value = 0.04168
    #alternative hypothesis: true mean is not equal to 1500
    #95 percent confidence interval:
    #  1492.431 1499.849
    #sample estimates:
    #  mean of x 
    #1496.14 
    # our p-value is below , p-value = 0.04168, below mean 1500

plt <- ggplot(suspension,aes(x=Manufacturing_Lot,y=PSI)) #import dataset into ggplot2
plt + geom_boxplot() #add boxplot
#Deliverable 4: Design a Study Comparing the MechaCar to the Competition
#Design a statistical study to compare vehicle performance of the MechaCar vehicles against vehicles from other manufacturers. For each statistical analysis, you'll write a summary interpretation of the findings.

