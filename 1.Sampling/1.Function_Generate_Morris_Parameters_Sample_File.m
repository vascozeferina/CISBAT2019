clear

p=10;%Number of levels
r=50;%Trajectories

%NumFact=8; %(k) number of factors
%Envelope

%% @@EP9_IHG@@	@@EP10_VRate@@	@@EP11_Inf@@	@@EP12_C_SP@@	@@EP14_Gla@@	@@EP15_Rat@@	@@EP16_RA@@	
%% @@P1@@	@@P2@@	@@P3@@	@@P4@@	@@P5@@	@@P6@@	@@P7@@	@@P8@@	@@P9@@	@@P10@@


P1L=10;     P1U=80;        %Int Heat Gains
P2L=0.0005; P2U=0.01;      %Ventilation Rate
P3L=20;     P3U=28;        %Cool. Set Point
P4L=0.1;    P4U=10;        %Area Ratio
P5L=5;      P5U=9;         %Chiller SP
P6L=2.5;    P6U=6;         %Chiller COP 
P7L=1.0;    P7U=1.4;       %Sizing Factor
P8L=0.1;    P8U=0.4;       %Unloading Factor

%All 8 Parameter
LBO=[P1L;P2L;P3L;P4L;P5L;P6L;P7L;P8L];   %P1-P8
UBO=[P1U;P2U;P3U;P4U;P5U;P6U;P7U;P8U];  %P1-P8


k=8; %Number of factors
[Outmatrix, OutFact] = Function_Input_Sampling(p, k, r, LBO, UBO, []); %Output matrix

%Create a Matlab Matrix with Input info of the method
save('New_Input_MorrisTest_Parameter_Samples_Info.mat','OutFact','k','p','r')
%Create a csv with values
csvwrite('NEW_Joblist_Morris.csv',Outmatrix)



%It is necessary to adapt the final Joblist file, as it not include the
%other 17-8 variables/parameters