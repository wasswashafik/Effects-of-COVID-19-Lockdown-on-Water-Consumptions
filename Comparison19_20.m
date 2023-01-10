%% Effects of the COVID-19 Lockdown on Water Consumptions: a Northern Italy Case Study
% Stefano Alvisi, Marco Franchini, Chiara Luciani, Irene Marzola, Filippo Mazzoni
% Note. This code has been developed and tested by using MATLAB® version R2019b.
% In order for this script to work, both "DataAnalysis2019.m" and
% "DataAnalysis2020" must have been executed.

% In this script all the comparisons between 2019 and 2020 data are made,
% the demand profiles are clustered and all the figures are plotted.


%% TOTAL DAILY VOLUME OF THE PERIOD 1st FEBRUARY - 3th MAY

figure(1)
set(gcf,'Position',[100 100 700 420])
plot(timevolmonth20,volmesi20daytot/1000,'-k','Linewidth',1.5)
set(gca,'FontSize',15)
set(gca, 'FontName', 'Times New Roman')
ylabel('V_d (m^3)')
grid on
hold on
plot(timevolmonth20([1,23]),mean(volmesi20daytot(1:22))/1000*ones(2,1),'--k','Linewidth',1.5)
plot(timevolmonth20([23,40]),mean(volmesi20daytot(23:39))/1000*ones(2,1),'--k','Linewidth',1.5)
plot(timevolmonth20([40,end]),mean(volmesi20daytot(40:end))/1000*ones(2,1),'--k','Linewidth',1.5)

xlim([timevolmonth20(1),timevolmonth20(end)])

in=find(timevolmonth20.Day==11 & timevolmonth20.Month==3);
plot([timevolmonth20(in), timevolmonth20(in)],[50,90],'k-')
in=find(timevolmonth20.Day==23 & timevolmonth20.Month==2);
plot([timevolmonth20(in), timevolmonth20(in)],[50,90],'k-')

str={'Suspension of','school activities','in Veneto'};
text(5,85,str,'FontName', 'Times New Roman','Fontsize',11)
str={'Lockdown','start'};
text(40,85,str,'FontName', 'Times New Roman','Fontsize',11)


%% HISTOGRAM 
%Histogram of the difference between average daily volume of 2020 and 2019
figure(2)
histogram(mean(vol20dayresid,2)-mean(voldayresid,2),'Normalization','probability','FaceColor',[0.8 0.8 0.8])
set(gca,'FontSize',15)
set(gca, 'FontName', 'Times New Roman')
xlabel('\DeltaV (L)')
ylabel('f (-)')
grid on


%% SCATTER PLOT 
%Scatter plot between the variation in the volume of water consumed by each
%residential user and the average daily consumption of the same users in 2019
figure(3)
plot(mean(voldayresid,2),mean(vol20dayresid,2)-mean(voldayresid,2),'.k','markersize',20)
set(gca,'FontSize',15)
set(gca, 'FontName', 'Times New Roman')
ylabel('\DeltaV (L)')
xlabel('V_2_0_1_9 (L)')

grid on
grid minor



%% WEEKLY PATTERN
%comparison of the pattern of average consumption of the set of
%residential users on different days of the week in 2019 with the on in 2020 

figure(4)
plot(1:7,volweektotresid/1000,'-k','linewidth',2)
set(gca,'FontSize',15)
set(gca, 'FontName', 'Times New Roman')
xticks(1:7)
labels = {'Mon','Tue','Wed','Thu','Fri','Sat','Sun'};
xticklabels(labels)
hold on
grid on
ylim([54 80])
ylabel('V_d_,_r (m^3)')
xlabel('t (day)')
plot(1:7,vol20weektotresid/1000,'--k','linewidth',2)
legend('2019','2020','location','NorthWest')




%% HOURLY PATTERNS
%Comparison of the patterns of the hourly consumption coefficients of the set of
%residential users in 2019 with the one in 2020 



tt=[0:23;1:24];
tt=tt(:);

figure(5)
set(gcf,'Position',[100 100 1200 320])

subplot(1,3,1)
annotation('textbox',...
    [0.082 0.9 0.06 0.07],...
    'String','a)',...
    'FontSize',15,...
    'FontName','Times New Roman',...
    'FitBoxToText','off',...
    'EdgeColor','none');

Patdimincrem=[patadimhourtotDMA{1};patadimhourtotDMA{1}];
Patdimincrem=Patdimincrem(:);

Patdimincrem20=[pat20adimhourtotDMA{1};pat20adimhourtotDMA{1}];
Patdimincrem20=Patdimincrem20(:);

plot(tt,Patdimincrem,'k-','linewidth',2)
hold on
plot(tt,Patdimincrem20,'k--','linewidth',2)
grid on
set(gca,'FontSize',15)
set(gca, 'FontName', 'Times New Roman')
grid minor
xlabel('t (hour)')
xlim([0 24])
legend('2019','2020')
ylim([0 2.5])
ylabel('C_h (-)')
title('Weekdays')

subplot(1,3,2)
annotation('textbox',...
    [0.362 0.9 0.06 0.07],...
    'String','b)',...
    'FontSize',15,...
    'FontName','Times New Roman',...
    'FitBoxToText','off',...
    'EdgeColor','none');
Patdimincrem=[patadimhourtotDMA{2};patadimhourtotDMA{2}];
Patdimincrem=Patdimincrem(:);

Patdimincrem20=[pat20adimhourtotDMA{2};pat20adimhourtotDMA{2}];
Patdimincrem20=Patdimincrem20(:);

plot(tt,Patdimincrem,'k-','linewidth',2)
hold on
plot(tt,Patdimincrem20,'k--','linewidth',2)
grid on
set(gca,'FontSize',15)
set(gca, 'FontName', 'Times New Roman')
grid minor
xlabel('t (hour)')
xlim([0 24])
legend('2019','2020')
ylim([0 2.5])
ylabel('C_h (-)')
title('Saturdays')


subplot(1,3,3)
annotation('textbox',...
    [0.645 0.9 0.06 0.07],...
    'String','c)',...
    'FontSize',15,...
    'FontName','Times New Roman',...
    'FitBoxToText','off',...
    'EdgeColor','none');
Patdimincrem=[patadimhourtotDMA{3};patadimhourtotDMA{3}];
Patdimincrem=Patdimincrem(:);

Patdimincrem20=[pat20adimhourtotDMA{3};pat20adimhourtotDMA{3}];
Patdimincrem20=Patdimincrem20(:);

plot(tt,Patdimincrem,'k-','linewidth',2)
hold on
plot(tt,Patdimincrem20,'k--','linewidth',2)
grid on
grid minor
set(gca,'FontSize',15)
set(gca, 'FontName', 'Times New Roman')

xlabel('t (hour)')
xlim([0 24])
legend('2019','2020')
ylim([0 2.5])
ylabel('C_h (-)')
title('Sundays/Holidays')


%% BOX PLOT

%Differences between the daily consumption patterns for weekdays for each of the 208 residential users in 2020 and 2019


assex=zeros(24*length(matrresid),1);
cont=1;
for i=1:length(matrresid):length(assex)
    assex(i:i+length(matrresid)-1)=cont;
    cont=cont+1;
end

figure(6)
set(gcf,'Position',[488,342,958,420])
assey=pat20singlehourresid{1}(:)-patsinglehourresid{1}(:);
boxplot(assey,assex,'labels',{'00-01','','02-03','','04-05','','06-07','','08-09','','10-11','','12-13','','14-15','','16-17','','18-19','','20-21','','22-23',''})
ylim([-50 50])
xlabel('t (hour)')
set(gca,'FontSize',15)
set(gca, 'FontName', 'Times New Roman')
grid on
ylabel('\DeltaQ (L/h)')
a = get(get(gca,'children'),'children'); 
set(a, 'Color', 'k');
h = findobj(gcf,'tag','Outliers');
set(h,'MarkerEdgeColor','k')


%% DEMAND PROFILES CLUSTERING

% The hourly average water consumption for each user (1,2,...,208) with
% respect to the average weekday.
demwd19 = patsinglehourresid{1};
demwd20 = pat20singlehourresid{1};

% Data for years 2019 and 2020 are grouped in variable 'demwd'. The hourly
% average water consumption for each user and year is normalised through
% the average daily water consumption.
demwd = [demwd19; demwd20];
for i = 1:size(demwd,1)
    if sum(demwd(i,:))==0
       demwdnorm(i,:) = zeros(1,size(demwd,2));
    else
       demwdnorm(i,:)=demwd(i,:)/mean(demwd(i,:));
    end
end

% The K-means clustering algorithm is applied. The number of clusters is
% described by parameter 'k', while values for 'MaxIter' and 'Replicates'
% are chosen in order to have convergence of the solution. The centroid of
% each cluster (i.e. the 24 hourly consumption coefficient associated with
% each cluster) is expressed as a row of matrix 'centroids', while their
% corresponding cluster indexes (i.e. 1,2,...,k) are inserted in variable
% 'idx'.
k = 3;
[idx, centroids] = kmeans(demwdnorm,k,'MaxIter',300000,'Replicates',1000);

% Vectors idx19 and idx20 include the cluster index associated with each of
% the 208 users for years 2019 and 2020.
idx19 = idx(1:size(demwdnorm,1)/2);
idx20 = idx(size(demwdnorm,1)/2+1:size(demwdnorm,1));

% The k-centroids and their corresponding k-indexes are sorted based on the
% increasing time of peak demand. Matrix 'peaktime_class' includes peak
% demand times of each cluster on the first row and their corresponding
% cluster indexes on the second row.
for i = 1:k
    [~,pos] = max(centroids(i,:));
    peaktime_class(:,i) = [pos;i];
end
[temp, order] = sort(peaktime_class(1,:));
peaktime_class = peaktime_class(:,order);

% Vectors 'idxmod19' and 'idxmod20' include the cluster index (sorted based
% on the increasing time of peak demand) associated with each of the 208
% users for years 2019 and 2020.
for i = 1:k
    idxmod19(idx19==i)=find(peaktime_class(2,:)==i);
    idxmod20(idx20==i)=find(peaktime_class(2,:)==i);
end

% Correlation matrix. A square matrix of order k (i.e. 'corr') is
% determined, where the cell of position (i,j) (i,j=1,2,...,k) includes the
% number of residential users whose water consumption profile for weekdays
% of year 2019 was clustered to i-category and whose water consumption
% profile for weekdays of year 2020 was clustered to j-category. As a
% consequence, the trace of 'corr' includes the number of users whose
% cluster category has not changed from 2019 to 2020.
corr = zeros(k,k);
for i = 1:length(idx19)
    corr(idxmod19(i),idxmod20(i)) = corr(idxmod19(i),idxmod20(i))+1;
end


% A figure is created, including the obtained centroids (k) and the demand
% profiles of all their corresponding users for years 2019 and 2020.

figure(7)
set(gcf,'Position',[100 100 320*k 600])
set(gca, 'FontName', 'Times New Roman')
set(gca,'FontSize',15)

% Year 2019 subplots
for i = 1:length(idx19)
    class = idx19(i);
    subplot(2,k,find(peaktime_class(2,:)==class))
    set(gca, 'FontName', 'Times New Roman')

    plot(demwdnorm(i,:),'linewidth',1,'color',[.65 .65 .65]);
    hold on
    grid on
    axis([1 24 0 15])
    xticks(linspace(1,24,5))  
    xticklabels({'00','06','12','18','24'})
    xlabel('\fontsize{15} t (hour)')
    a = get(gca,'XTickLabel');  
    set(gca,'XTickLabel',a,'fontsize',15)
    yticks(0:3:15)
    b = get(gca,'YTickLabel');  
    set(gca,'YTickLabel',b,'fontsize',15)
    ylabel('C_h (-)')
    
end
subplot(2,3,1)
yy1 = (['\bf\fontsize{15}',append('2019')]);
yy2 = {append('    ')};
yy3 = (['\rm\fontsize{15}',append('C_h (-)')]);
ylabel([yy1; yy2; yy3])

for i = 1:k   
    subplot(2,k,i)
    plot(centroids(peaktime_class(2,i),:),'k','linewidth',3)
    set(gca, 'FontName', 'Times New Roman')
    hold on
    clsyr = {append('K = ',num2str(i))};
    usersprc = (['\fontsize{15}\color[rgb]{0 0 0} ',...
                   append(num2str(round(100*length(find(idx19==peaktime_class(2,i)))/length(idx19)))),'% of users']);
    title([clsyr; usersprc])
end

% Year 2020 subplots
for i = 1:length(idx20)
    class = idx20(i);
    subplot(2,k,k+find(peaktime_class(2,:)==class))
    plot(demwdnorm(length(idx19)+i,:),'linewidth',1,'color',[.65 .65 .65])
    set(gca, 'FontName', 'Times New Roman')
    hold on
    grid on
    axis([1 24 0 16])
    xticks(linspace(1,24,5))   
    xticklabels({'00','06','12','18','24'})
    xlabel('\fontsize{15} t (hour)')
    a = get(gca,'XTickLabel');  
    set(gca,'XTickLabel',a,'fontsize',15)
    yticks(0:3:15)
    b = get(gca,'YTickLabel');  
    set(gca,'YTickLabel',b,'fontsize',15)
    ylabel('\fontsize{15} C_h (-)')
end
subplot(2,3,4)
yy1 = (['\bf\fontsize{15}',append('2020')]);
yy2 = {append('    ')};
yy3 = (['\rm\fontsize{15}',append('C_h (-)')]);
ylabel([yy1; yy2; yy3])

for i = 1:k
    subplot(2,k,i+k)
    plot(centroids(peaktime_class(2,i),:),'k','linewidth',3)
    set(gca, 'FontName', 'Times New Roman')
    hold on
    usersprc = (['\fontsize{15}\color[rgb]{0 0 0}',...
        append(num2str(round(100*length(find(idx20==peaktime_class(2,i)))/length(idx20)))),'% of users']);
    title(usersprc)
end


%% COMMERCIAL USERS

%Hourly consumption pattern of 4 commercial users, namely, a pharmacy, a
%hardware store, a holistic centre and a hairdresser

tt=[0:23;1:24];
tt=tt(:);

figure(8)
set(gcf,'Position',[350 160 820 615])

subplot(2,2,1)
annotation('textbox',...
    [0.059 0.91 0.056 0.072],...
    'String','a)',...
    'FontSize',15,...
    'FontName','Times New Roman',...
    'FitBoxToText','off',...
    'EdgeColor','none');
Patdimincrem=[patsinglehourcomm{1}(5,:);patsinglehourcomm{1}(5,:)];
Patdimincrem=Patdimincrem(:);

Patdimincrem20=[pat20singlehourcomm{1}(5,:);pat20singlehourcomm{1}(5,:)];
Patdimincrem20=Patdimincrem20(:);

plot(tt,Patdimincrem,'k-','linewidth',2)
hold on
plot(tt,Patdimincrem20,'k--','linewidth',2)
grid on
grid minor
set(gca,'FontSize',15)
set(gca, 'FontName', 'Times New Roman')

xlabel('t (hour)')
xlim([0 24])
legend('2019','2020')
ylim([0 40])
ylabel('Q (L/h)')
title('Pharmacy')

subplot(2,2,2)
annotation('textbox',...
    [0.49 0.91 0.056 0.072],...
    'String','b)',...
    'FontSize',15,...
    'FontName','Times New Roman',...
    'FitBoxToText','off',...
    'EdgeColor','none');
Patdimincrem=[patsinglehourcomm{1}(3,:);patsinglehourcomm{1}(3,:)];
Patdimincrem=Patdimincrem(:);

Patdimincrem20=[pat20singlehourcomm{1}(3,:);pat20singlehourcomm{1}(3,:)];
Patdimincrem20=Patdimincrem20(:);

plot(tt,Patdimincrem,'k-','linewidth',2)
hold on
plot(tt,Patdimincrem20,'k--','linewidth',2)
grid on
grid minor

set(gca,'FontSize',15)
set(gca, 'FontName', 'Times New Roman')

xlabel('t (hour)')
xlim([0 24])
legend('2019','2020')
ylim([0 40])
ylabel('Q (L/h)')
title('Hardware store')


subplot(2,2,3)
annotation('textbox',...
     [0.059 0.44 0.056 0.072],...
    'String','c)',...
    'FontSize',15,...
    'FontName','Times New Roman',...
    'FitBoxToText','off',...
    'EdgeColor','none');
Patdimincrem=[patsinglehourcomm{1}(7,:);patsinglehourcomm{1}(7,:)];
Patdimincrem=Patdimincrem(:);

Patdimincrem20=[pat20singlehourcomm{1}(7,:);pat20singlehourcomm{1}(7,:)];
Patdimincrem20=Patdimincrem20(:);

plot(tt,Patdimincrem,'k-','linewidth',2)
hold on
plot(tt,Patdimincrem20,'k--','linewidth',2)
grid on
grid minor
set(gca,'FontSize',15)
set(gca, 'FontName', 'Times New Roman')

xlabel('t (hour)')
xlim([0 24])
legend('2019','2020')
ylim([0 40])
ylabel('Q (L/h)')
title('Holistic Centre')


subplot(2,2,4)
annotation('textbox',...
    [0.49 0.44 0.056 0.072],...
    'String','d)',...
    'FontSize',15,...
    'FontName','Times New Roman',...
    'FitBoxToText','off',...
    'EdgeColor','none');
Patdimincrem=[patsinglehourcomm{1}(6,:);patsinglehourcomm{1}(6,:)];
Patdimincrem=Patdimincrem(:);

Patdimincrem20=[pat20singlehourcomm{1}(6,:);pat20singlehourcomm{1}(6,:)];
Patdimincrem20=Patdimincrem20(:);

plot(tt,Patdimincrem,'k-','linewidth',2)
hold on
plot(tt,Patdimincrem20,'k--','linewidth',2)
grid on
grid minor
set(gca,'FontSize',15)
set(gca, 'FontName', 'Times New Roman')

xlabel('t (hour)')
xlim([0 24])
legend('2019','2020')
ylim([0 40])
ylabel('Q (L/h)')
title('Hairdresser')



