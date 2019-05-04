clear

%% Initialize variables.

folder='D:\Tsinghua Simulations\CISBAT Test\4.Git_Hub\2.Simulation_Results\'
file='1.Original_Paper_AllCombinedResults_Morris.csv'
filename = strcat(folder , file)
%filename = 'D:\Tsinghua Simulations\CISBAT Test\Paper Analysis\1.Morris_8P_50_Trajectories\Morris Calculation\AllCombinedResults.csv';
delimiter = ',';
startRow = 2;

%% Format for each line of text:
%   column29: double (%f)
%	column32: double (%f)
%   column38: double (%f)
%	column41: double (%f)
%   column46: double (%f)
% For more information, see the TEXTSCAN documentation.
formatSpec = '%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%f%*s%*s%f%*s%*s%*s%*s%*s%f%*s%*s%f%*s%*s%*s%*s%f%*s%*s%*s%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to the format.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string', 'HeaderLines' ,startRow-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');

%% Close the text file.
fclose(fileID);

%% Post processing for unimportable data.
% No unimportable data rules were applied during the import, so no post
% processing code is included. To generate code which works for
% unimportable data, select unimportable cells in a file and regenerate the
% script.

%% Create output variable
AllCombinedResults = [dataArray{1:end-1}];
%% Clear temporary variables
clearvars filename delimiter startRow formatSpec fileID dataArray ans;

Annual=(AllCombinedResults(:,1)+AllCombinedResults(:,2))./AllCombinedResults(:,5);
Peak=(AllCombinedResults(:,3)+AllCombinedResults(:,4))./AllCombinedResults(:,5);



%Store Output Results Annual and Peak for Total and Space Cooling
Out_Res=[Peak,Annual];
%Calculate Statistical values of output results sample
Out_Avg=mean(Out_Res);
Out_Max=max(Out_Res);
Out_Min=min(Out_Res);
Out_Median=median(Out_Res);
Out_Mode=mode(Out_Res);
Out_std=std(Out_Res);
Out_var=var(Out_Res);

An_Base=38.9
PK_Base=16.3


Out_matrix=[Out_Avg;Out_Max;Out_Min;Out_Median;Out_Mode;Out_std;Out_var];

Out_matrix_based(:,2)=Out_matrix(:,2)/An_Base-1
Out_matrix_based(:,1)=Out_matrix(:,1)/PK_Base-1

Out_Mat=[Out_matrix Out_matrix_based]

Out_Table = array2table(Out_Mat,'VariableNames',{'PT','AT','PTBase','ATBase'},'RowNames',{'Mean','Max','Min','Median','Mode','Std','Var'})

%Make a output result
%save('Morris_Simulation_Output.mat','Out_Table','Out_Res')



% %All Peak Results per column
save('NEW_Output_Simulation_Result.mat','Out_Table','Out_Res')

%Collect Annual Energy Demand and Peak Demand for all Climate Simulations

%load('Output_Simulation_Result.mat')
%CLIMATE C5 - Control
An_Max=max(Annual(:,1));
An_Min=min(Annual(:,1));
An_Mean=mean(Annual(:,1));

Pk_Max=max(Peak(:,1));
Pk_Min=min(Peak(:,1));
Pk_Mean=mean(Peak(:,1));

Header=["Max.","Mean","Min."]';
Annual_kWh_sqm=[An_Max,An_Mean,An_Min]';
Peak_W_sqm=[Pk_Max,Pk_Mean,Pk_Min]';
Table_Clim_5=table(Header,Annual_kWh_sqm,Peak_W_sqm);

load('1.Original_Input_MorrisTest_Parameter_Samples_Info.mat');

i=k+1; %Number of factors + 1

V=p/(2*(p-1));


for n3=1:1 %For Elec and then Space Cooling
for n1=1:r    %Number of trajectories
     for n2=1:i-1   %Number of Factors
        in=OutFact((n1-1)*i+n2);  %Factor varied
        %DT1=Outmatrix((n1-1)*i+n2+1,in);  %Input posterior
        %DT0=Outmatrix((n1-1)*i+n2,in); %Input antecessor
        EnDelta=Annual((n1-1)*i+n2+1,n3)-Annual((n1-1)*i+n2,n3);
        PeakDelta=Peak((n1-1)*i+n2+1,n3)-Peak((n1-1)*i+n2,n3);
        
        EE_En(n1,in,n3)=EnDelta/V;  %Variance
        EE_Peak(n1,in,n3)=PeakDelta/V;  %Variance
     end 
end
        
end




%sigma=sqrt(
for n3=1:1  
    for n2=1:i-1   
u_En(n3,n2)=sum(abs(EE_En(:,n2,n3)))/r;   %Calculate u*
u_Peak(n3,n2)=sum(abs(EE_Peak(:,n2,n3)))/r;   %Calculate u*

sigma_En(n3,n2)=sqrt(sum((EE_En(:,n2,n3)-u_En(n3,n2)).^2)/(r-1));  %Calculate sigmas
sigma_Peak(n3,n2)=sqrt(sum((EE_Peak(:,n2,n3)-u_Peak(n3,n2)).^2)/(r-1));  %Calculate sigmas
      
    end
end

[x1En,xiEn]=sort(u_En,2,'descend'); %Descend order Annual
[x1P,xiP]=sort(u_Peak,2,'descend'); %Descend order Peak

%RCP=u_Peak(5,:)./u_Peak(1,:)-1;
%RCEn=u_En(5,:)./u_En(1,:)-1;


%Store Results of sensitivity metrics
save('NEW_Output_Morris_Metrics_Result.mat','sigma_En','u_En','sigma_Peak','u_Peak','x1En','xiEn','x1P','xiP')


