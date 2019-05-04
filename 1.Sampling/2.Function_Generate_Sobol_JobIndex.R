rm(list=ls())
gc()

library(readxl)
library(sensitivity)
library(boot)
library(writexl)
library(boot)
library(gdata)

n <- 2500  #bootstrap iterations

p <- 8 #parameters

it <- (2+p)*n


P1LB <- 10
P1UB <- 80
P2LB <-0.0005 
P2UB <-0.01
P3LB <-20
P3UB <-28
P4LB <-0.1
P4UB <-10
P5LB <-5
P5UB <-9
P6LB <-2.5
P6UB <-6
P7LB <-1
P7UB <-1.4
P8LB <-0.1
P8UB <-0.4

  

P1_1 <-runif(n, min = P1LB, max = P1UB)
P2_1 <-runif(n, min = P2LB, max = P2UB)
P3_1 <-runif(n, min = P3LB, max = P3UB)
P4_1 <-runif(n, min = P4LB, max = P4UB)
P5_1 <-runif(n, min = P5LB, max = P5UB)
P6_1 <-runif(n, min = P6LB, max = P6UB)
P7_1 <-runif(n, min = P7LB, max = P7UB)
P8_1 <-runif(n, min = P8LB, max = P8UB)

X1 <- data.frame(P1_1,P2_1,P3_1,P4_1,P5_1,P6_1,P7_1,P8_1, row.names = NULL, check.names = FALSE)

P1_1 <-runif(n, min = P1LB, max = P1UB)
P2_1 <-runif(n, min = P2LB, max = P2UB)
P3_1 <-runif(n, min = P3LB, max = P3UB)
P4_1 <-runif(n, min = P4LB, max = P4UB)
P5_1 <-runif(n, min = P5LB, max = P5UB)
P6_1 <-runif(n, min = P6LB, max = P6UB)
P7_1 <-runif(n, min = P7LB, max = P7UB)
P8_1 <-runif(n, min = P8LB, max = P8UB)

X2 <- data.frame(P1_1,P2_1,P3_1,P4_1,P5_1,P6_1,P7_1,P8_1, row.names = NULL, check.names = FALSE)

names(X2) <- names(X1) 

# sensitivity analysis

xSoboljansen <- soboljansen(model = NULL, X1, X2, nboot = n, conf = 0.95)


A <- seq(1, it, 1)
#A <-paste(Case,A, sep='')
B <- matrix(0, it, 2)
P1 <- xSoboljansen$X$P1
P2 <- xSoboljansen$X$P2
P3 <- matrix(0.00012, it, 1)
P4 <- xSoboljansen$X$P3
P5 <-  matrix(0.4, it, 1)
P6 <-  matrix(1, it, 1)
P7 <- xSoboljansen$X$P4  
P8 <- matrix(1, it, 1)     
P9 <- matrix(1, it, 1) 
P10 <- matrix(12, it, 1)
P11 <-  xSoboljansen$X$P5
P12 <- matrix(27, it, 1) 
P13 <-  xSoboljansen$X$P6
P14 <- xSoboljansen$X$P7
P15 <- xSoboljansen$X$P8
P16 <- matrix(1.1, it, 1) 
P17 <- matrix(50, it, 1) 


MyData <- data.frame(A, B,P1,P2,P3,P4,P5,P6,P7,P8,P9,P10,P11,P12,P13,P14,P15,P16,P17)

Folder="D:/Tsinghua Simulations/CISBAT Test/3.Paper Analysis/2.Sobol/1.Sampling/"

File_name_JobIndex=paste(Folder,"NEW_JobIndex_SOBOL_N",n,"_P",p,".csv",sep="")
File_nameX1=paste(Folder,"New_SOBOL_X1_N_",n,"_P",p,".csv",sep="")
File_nameX2=paste(Folder,"New_SOBOL_X2_N_",n,"_P",p,".csv",sep="")

  
write.table(MyData, file = File_name, col.names = FALSE, row.names = FALSE, sep = ",")
write.table(X1, file = File_nameX1, col.names = FALSE, row.names = FALSE, sep = ",")
write.table(X2, file = File_nameX2, col.names = FALSE, row.names = FALSE, sep = ",")