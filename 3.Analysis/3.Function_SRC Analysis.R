rm(list=ls())
gc()

library(readxl)
library(sensitivity)
library(boot)
library(writexl)

#Importing the input sample

InputFolder="D:/Tsinghua Simulations/CISBAT Test/3.Paper Analysis/3.SRC/1.Sampling/"
File_Name="3.Original_Paper_SOBOL_X1_N_2500_P8.csv"
File_name=paste(InputFolder,File_Name,sep="")

X <- read.csv(File_name,header=FALSE)

CurrentFolder="D:/Tsinghua Simulations/CISBAT Test/3.Paper Analysis/3.SRC/2.Result_Analysis/"
ResultFile=paste(CurrentFolder,"3.OriginalPaper_AllCombinedResults_SRC.csv",sep="")

#Importing the simulation results
MyData <- read.csv(file=ResultFile,header=TRUE, sep=",")



#Fans(2)
Peak_P2 <- MyData$c10..P2_Ele_Fan_.W.
Annual_A2 <- MyData$c1..A2_Ele_Fan_.kWh.
#Plant(5)
Peak_P5 <- MyData$c13..P5_Ele_Plant.W.
Annual_A5 <- MyData$c4..A5_Ele_Plant.kWh.
#PT and AT summin (2) and (5)
Peak=Peak_P2+Peak_P5
Annual=Annual_A2+Annual_A5

Area=MyData$c18..O1_Floor.Area.m2.

#Intensity per area
y_PK_El=Peak/Area
y_An_El=Annual/Area


X <- data.frame(X)

#Calculation the SRC metrics
PK_El_SA_SRC <- src(X, y_PK_El, nboot = 2500)
An_El_SA_SRC <- src(X, y_An_El, nboot = 2500)
PK_El_SA_SRRC<- src(X, y_PK_El,  rank = TRUE, nboot = 2500)
An_El_SA_SRRC<- src(X, y_An_El,  rank = TRUE, nboot = 2500)

#Presenting the metric results
PK_El_SA_SRRC$SRRC$original #Peak SRRC
PK_El_SA_SRC$SRC$original #Peak SRC
An_El_SA_SRC$SRC$original #Annual SRRC
An_El_SA_SRRC$SRRC$original #Peak SRC

#Plots
plot(PK_El_SA_SRC)
plot(PK_El_SA_SRRC)
plot(An_El_SA_SRC)
plot(An_El_SA_SRRC)

#Creating the table for peak and Annual / considering both SRC and SRRC
PK_SRC <-cbind(PK_El_SA_SRC$SRC$original, PK_El_SA_SRRC$SRRC$original , deparse.level = 1)
AN_SRC <-cbind(An_El_SA_SRC$SRC$original, An_El_SA_SRRC$SRRC$original , deparse.level = 1)

#Calculating the range of results
Max_Peak <- max(y_PK_El)
Min_Peak <- min(y_PK_El)
Mean_Peak <- mean(y_PK_El)

Peak_Sum <-cbind(Mean_Peak,Max_Peak, Min_Peak, deparse.level = 1)
# 
Max_Annual <- max(y_An_El)
Min_Annual <- min(y_An_El)
Mean_Annual <- mean(y_An_El)
# 
Annual_Sum <-cbind(Mean_Annual,Max_Annual, Min_Annual, deparse.level = 1)

#Presenting over the base value (rated to %)
Peak_Sum_Based=Peak_Sum/16.3-1
Annual_Sum_Based=Annual_Sum/38.9-1

#Create a matrix about it
Annual_Sum <-cbind(Annual_Sum,Annual_Sum_Based, deparse.level = 1)
Peak_Sum <-cbind(Peak_Sum,Peak_Sum_Based, deparse.level = 1)

OutputFolder="D:/Tsinghua Simulations/CISBAT Test/3.Paper Analysis/3.SRC/"
File_Name="NEW_Out_SRC_N2500.xls"
Out_Excell_file=paste(OutputFolder,File_Name,sep="")

Out_Excell_file
AN_SRC

library(xlsx)

write.xlsx(Annual, Out_Excell_file,sheetName="Annual")
write.xlsx(AN_SRC, Out_Excell_file,sheetName="Annual")
write.xlsx(PK_SRC, Out_Excell_file,sheetName="Peak", append=TRUE)
write.xlsx(Peak_Sum, Out_Excell_file,sheetName="Summary_PK_El", append=TRUE)
write.xlsx(Annual_Sum, Out_Excell_file,sheetName="Summary_An_El", append=TRUE)
#write.xlsx(Peak_Sum, Out_Excell_file,sheetName="Summary_PK_El", append=TRUE)
#write.xlsx(Annual_Sum, Out_Excell_file,sheetName="Summary_An_El", append=TRUE)

