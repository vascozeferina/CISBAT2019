clear
load('Original_Paper_Output_Morris_Metrics_Result.mat')

%From Variable 1 (Electricity)
xEn1=u_En(1,:); %mu* for annual energy of the 1st sample
yEn1=sigma_En(1,:); %sigma for annual energy of the 1st sample

xP1=u_Peak(1,:); %mu* for peak of the 1st sample
yP1=sigma_Peak(1,:); %sigma for peak of the 1st sample

% %From Variable 2 (Space Cooling)
% xEn2=u_En(2,:); %mu* for annual energy of the 1st sample
% yEn2=sigma_En(2,:); %sigma for annual energy of the 1st sample
% 
% xP2=u_Peak(2,:); %mu* for peak of the 1st sample
% yP2=sigma_Peak(2,:); %sigma for peak of the 1st sample

%Figure()
% [x1P,xiP]=sort(xP,'descend');   %Rank of the Parameters with higher mean for Peak
% [x1En,xiEn]=sort(xEn,'descend'); %Rank of the Parameters with higher mean for Annual Demand

n=8
a=[1:n]'; b=num2str(a);cl=cellstr(b);
c=cell(n,1);

figure %For Peak plot _ Space cooling

scatter(xP1,yP1,20,'filled')
for i = 1:n
    c{i,1}=strcat('P',cl{i})
    text(xP1(1,i),yP1(1,i),c(i,1),'Fontsize',10);
end
set(gca,'FontSize',14)
xlabel('\mu*','Fontsize',20)
ylabel('\sigma','Fontsize',20)
title('Peak')

%cd Outputplots
saveas(gcf,'NEW_Peak_Morris_1.png')
close
 
% figure %For Peak plot _ Electricity
% 
% scatter(xP2,yP2,20,'filled')
% for i = 1:n
%     c{i,1}=strcat('P',cl{i})
%     text(xP2(1,i),yP2(1,i),c(i,1),'Fontsize',10);
% end
% set(gca,'FontSize',14)
% xlabel('\mu*','Fontsize',20)
% ylabel('\sigma','Fontsize',20)
% title('Peak 2')
% 
% saveas(gcf,'Peak_Morris_2.png')
% close

figure %For Peak plot _ Electricity

scatter(xEn1,yEn1,20,'filled')
for i = 1:n
    c{i,1}=strcat('P',cl{i})
    text(xEn1(1,i),yEn1(1,i),c(i,1),'Fontsize',10);
end
set(gca,'FontSize',14)
xlabel('\mu*','Fontsize',20)
ylabel('\sigma','Fontsize',20)
title('Annual')

saveas(gcf,'NEW_Energy_Morris_1.png')
close

% figure %For Peak plot _ Electricity
% 
% scatter(xEn2,yEn2,20,'filled')
% for i = 1:n
%     c{i,1}=strcat('P',cl{i})
%     text(xEn2(1,i),yEn2(1,i),c(i,1),'Fontsize',10);
% end
% set(gca,'FontSize',14)
% xlabel('\mu*','Fontsize',20)
% ylabel('\sigma','Fontsize',20)
% title('En 2')
% 
% saveas(gcf,'Energy_Morris_2.png')
% close


%T = [c';xP1;yP1]

TabPeak1=table(c,round(xP1)',round(yP1)','VariableNames',{'Par','u','sig'})  %Description of Table
% TabPeak2=table(c,round(xP2)',round(yP2)','VariableNames',{'Par','u','sig'})  %Description of Table
TabEn1=table(c,round(xEn1)',round(yEn1)','VariableNames',{'Par','u','sig'})  %Description of Table
% TabEn2=table(c,round(xEn2)',round(yEn2)','VariableNames',{'Par','u','sig'})  %Description of Table

TabPeak1 = sortrows(TabPeak1,'u','descend')
% TabPeak2 = sortrows(TabPeak2,'u','descend')
TabEn1 = sortrows(TabEn1,'u','descend')
% TabEn2 = sortrows(TabEn2,'u','descend')


