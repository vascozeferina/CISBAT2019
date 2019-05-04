rm(list=ls())
gc()

library(readxl)
library(sensitivity)
library(boot)
library(writexl)

n=2500
p=8

InputFolder="D:/Tsinghua Simulations/CISBAT Test/3.Paper Analysis/2.Sobol/1.Sampling/"

File_nameX1=paste(InputFolder,"2.Original_Paper_SOBOL_X1_N_",n,"_P",p,".csv",sep="")
File_nameX2=paste(InputFolder,"2.Original_Paper_SOBOL_X2_N_",n,"_P",p,".csv",sep="")
X1 <- read.csv(File_nameX1,header=FALSE)
X2 <- read.csv(File_nameX2,header=FALSE)

xSoboljansen <- soboljansen(model = NULL, X1, X2, nboot = n, conf = 0.95)
#xfast99 <- fast99(model = NULL, factors=6, n=250, M = 4, omega = NULL, q = NULL, q.arg = NULL)
xSobol2007 <- sobol2007(model = NULL, X1, X2, nboot = n, conf = 0.95)
xSobolmartinez <- sobolmartinez(model = NULL, X1, X2, nboot = n, conf = 0.95)

CurrentFolder="D:/Tsinghua Simulations/CISBAT Test/3.Paper Analysis/2.Sobol/2.Result_Analysis/"
Simulation_Out_File=paste(CurrentFolder,"2.Original_Paper_AllCombinedResults_Sobol.csv",sep="")

#View(x)
# write.xlsx(xSoboljansen[["X"]], "D:/Tsinghua Simulations/CISBAT Test/SOBOL Analysis/Input_Par_SOBOL_Jansen.xls")
# write.xlsx(xSobol2007[["X"]], "D:/Tsinghua Simulations/CISBAT Test/SOBOL Analysis/Input_Par_SOBOL_2007.xls")
# write.xlsx(xSobolmartinez[["X"]], "D:/Tsinghua Simulations/CISBAT Test/SOBOL Analysis/Input_Par_SOBOLmartinez.xls")
MyData <- read.csv(file=Simulation_Out_File,header=TRUE, sep=",")

#MyData$c1..A2_Ele_Fan_.kWh.

#Fans(2)
Peak_P2 <- MyData$c10..P2_Ele_Fan_.W.
Annual_A2 <- MyData$c1..A2_Ele_Fan_.kWh.
#Plant(5)
Peak_P5 <- MyData$c13..P5_Ele_Plant.W.
Annual_A5 <- MyData$c4..A5_Ele_Plant.kWh.
#PT and AT summin (2) and (5)
Peak=Peak_P2+Peak_P5
Annual=Annual_A2+Annual_A5

Area=MyData$c17..O1_Floor.Area.m2.
#Space cooling (6)

#Intensity per area
y_PK_El=Peak/Area
y_An_El=Annual/Area


## S3 method for class 'sobol'

sa1_PK_El <- tell(xSobol2007, y_PK_El)
sa2_PK_El <- tell(xSoboljansen, y_PK_El)
sa3_PK_El <- tell(xSobolmartinez, y_PK_El)

sa1_An_El <- tell(xSobol2007, y_An_El)
sa2_An_El <- tell(xSoboljansen, y_An_El)
sa3_An_El <- tell(xSobolmartinez, y_An_El)








sa1_An_El$T$original
sa1_An_El$S$original

sa2_An_El$T$original
sa2_An_El$S$original

sa3_An_El$T$original
sa3_An_El$S$original



 AN_2 <-cbind(sa2_An_El$T$original, sa2_An_El$S$original, deparse.level = 1)
 PK_2 <-cbind(sa2_PK_El$T$original, sa2_PK_El$S$original, deparse.level = 1)
 AN_3 <-cbind(sa3_An_El$T$original, sa3_An_El$S$original, deparse.level = 1)
 PK_3 <-cbind(sa3_PK_El$T$original, sa3_PK_El$S$original, deparse.level = 1)

plot(sa2_PK_El$T$original,col="red")
points(sa2_PK_El$S$original,col="green")

plot(sa3_PK_El$T$original,col="red")
points(sa3_PK_El$S$original,col="green")

plot(sa2_An_El$T$original,col="red")
points(sa2_An_El$S$original,col="green")

plot(sa3_An_El$T$original,col="red")
points(sa3_An_El$S$original,col="green")

Peak_Sum <- summary(y_PK_El)
Annual_Sum <-summary(y_An_El)

#View(Peak_Sum)
# }

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

#View(Peak_Sum)
Peak_Sum_Based=Peak_Sum/16.3-1
#View(Peak_Sum_Based)

Annual_Sum_Based=Annual_Sum/38.9-1
# View(Annual_Sum_Based)
# View(Annual_Sum)



Out_Excell_file= paste(CurrentFolder,"NEW_Out_SOBOL_SAInd_N",n,"_P",p,".xls",sep="")

library(xlsx)
write.xlsx(AN_2, Out_Excell_file,sheetName="Annual_2")
write.xlsx(PK_2, Out_Excell_file,sheetName="Peak_2", append=TRUE)
write.xlsx(AN_3, Out_Excell_file,sheetName="Annual_3", append=TRUE)
write.xlsx(PK_3, Out_Excell_file,sheetName="Peak_3", append=TRUE)
write.xlsx(Peak_Sum, Out_Excell_file,sheetName="Summary_PK_El", append=TRUE)
write.xlsx(Annual_Sum, Out_Excell_file,sheetName="Summary_An_El", append=TRUE)

