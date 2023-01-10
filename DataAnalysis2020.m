%% Effects of the COVID-19 Lockdown on Water Consumptions: a Northern Italy Case Study
% Stefano Alvisi, Marco Franchini, Chiara Luciani, Irene Marzola, Filippo Mazzoni
% Note. This code has been developed and tested by using MATLAB® version R2019b.

%In this code the water consumptions from the period between the 4th of
%April and the 3th of May of 2020 are analyzed.

%At first the cumulative volumes of every users of the DMA are imported
%along with their identification number and the time steps. Only the period
%of interest is extrapolated from the dataset. The users which have
%leakages within the house, no consumptions or empty data are eliminated
%from the dataset and residential and commercial users are separated.

%The evaluations carried out follow belows:
% - the daily volumes consumed for every users and the average daily
%   volumes consumed for both the whole sets of residential and commercials users;
% - pattern of average consumption on different days of the week of the sets of residential users;
% - patterns of the hourly consumption and hourly consumption coefficients, separated in weekdays, saturdays and sundays. 
% - the peak consumptions for the hourly consumption patterns


%The water consumptions from the period between the 1st of Febraury and
%the 3th of May of 2020 were also considered and the total daily volume of
%this period is evaluated. 


%% IMPORT OF DATA

%Data importation
dati=importdata('dataset2020.csv');

timevoltot20=datetime(dati.textdata(:,2:end));
timevoltot20=datetime(timevoltot20, 'InputFormat','dd/MM/yy HH:mm','TimeZone','Europe/Rome');

vol20tot=dati.data(:,2:end)/1000;     %cubic meter
matricole=dati.data(:,1);

%There are two more users in 2020 than in 2019 that must be eliminated for
%consistence 

rig=find(matricole==10120713210);
matricole(rig)=[];
vol20tot(rig,:)=[];
rig=find(matricole==10120713215);
matricole(rig)=[];
vol20tot(rig,:)=[];


clear dati


%% EXTRAPOLATION OF PERIOD 1st FEBRAURY - 3th MAY OF 2020

indiniz=find(timevoltot20.Hour==0 & timevoltot20.Day==1 & timevoltot20.Month==2);
indfine=find(timevoltot20.Hour==0 & timevoltot20.Day==4 & timevoltot20.Month==5);

volmonth20=vol20tot(:,indiniz:indfine);
timevolmonth20=timevoltot20(indiniz:indfine);



%% EXTRAPOLATION OF PERIOD 4th APRIL - 3th MAY OF 2020

indiniz=find(timevoltot20.Hour==0 & timevoltot20.Day==4 & timevoltot20.Month==4);
indfine=find(timevoltot20.Hour==0 & timevoltot20.Day==4 & timevoltot20.Month==5);

vol20=vol20tot(:,indiniz:indfine);
timevol20=timevoltot20(indiniz:indfine);



clear indiniz indfine

%Evaluation of flows
flow20=zeros(length(matricole),length(timevol20)-1);

for i=1:length(timevol20)-1
    flow20(:,i)=(vol20(:,i+1)-vol20(:,i))*1000;      % liter/hour
end

timeflow20=timevol20(1:end-1);


%% SELECTION OF THE USERS

%Elimination of close users, with empty data or no consumption.
%Separation of residential an commercial users
load close.txt
load commercial.txt
load leakage.txt
load userwithnan.txt
load condominium.txt

for i=1:length(close)
    indclose(i,1)=find(matricole==close(i));
end

for i=1:length(condominium)
    indcondominium(i,1)=find(matricole==condominium(i));
end

for i=1:length(commercial)
    indcommercial(i,1)=find(matricole==commercial(i));
end

for i=1:length(leakage)
    indleakage(i,1)=find(matricole==leakage(i));
end

for i=1:length(userwithnan)
    indnan(i,1)=find(matricole==userwithnan(i));
end

indresid=removerows([1:length(matricole)]',[indcommercial; indclose; indcondominium; indleakage; indnan]);
matrcomm=matricole(indcommercial);
matrresid=matricole(indresid);

%Period 4th April - 4th May
vol20resid=vol20(indresid,:);
flow20resid=flow20(indresid,:);
vol20comm=vol20(indcommercial,:);
flow20comm=flow20(indcommercial,:);

%Period1st Febraury - 4th May
volmonth20=volmonth20([indresid; indcommercial],:);


%% DAY DIVISION

%Division of the days based on:
%0 weekdays
%1 saturdays
%2 sundays/holidays
%4 days not considered

data=importdata('day2020.xlsx');

daytime20=datetime(data.textdata);
daytype20=data.data; 
type=[0 1 2];

%Separation of the days according to their position in the week:
%1 Monday
%2 Tuesday
%3 Wednesday
%4 Thursday
%5 Friday
%6 Saturday
%7 Sunday
%999 day not considered

week2020=importdata('week2020.xlsx');



%% DAILY VOLUME AND AVERAGE DAILY VOLUME


%Period 1th February - 4th May
%Daily volume of every users and every day of the monitored period 
ind=find(timevolmonth20.Hour==0); 
for i=1:length(ind)-1
volmesi20day(:,i)=(volmonth20(:,ind(i+1))-volmonth20(:,ind(i)))*1000;   %liter
end
timevolmonth20=timevolmonth20(ind(1:end-1));
timevolmonth20.Format='dd-MMM-yyyy';
%Total daily volume for every day of the monitored period
volmesi20daytot=sum(volmesi20day,1);


%Period 4th April - 4th May
%Daily volume of every users and every day of the monitored period 
ind=find(timevol20.Hour==0); 
for i=1:length(ind)-1
vol20dayresid(:,i)=(vol20resid(:,ind(i+1))-vol20resid(:,ind(i)))*1000;   %liter
vol20daycomm(:,i)=(vol20comm(:,ind(i+1))-vol20comm(:,ind(i)))*1000;   %liter
end
%Average daily volume of the set of residential/commercial users
vol20meandaytotresid=mean(sum(vol20dayresid,1))/1000;  %cubic meter
vol20meandaytotcomm=mean(sum(vol20daycomm,1))/1000;   %cubic meter


%% WEEKLY PATTERN

vol20daytotresid=sum(vol20dayresid,1);

%Average daily volume for each day of the week of the set of residential
%users

for i=1:7
    ind20=find(week2020==i);
    vol20weektotresid(i)=mean(vol20daytotresid(ind20));
end

%% HOURLY PATTERN

%Patterns of the hourly consumption of the set of residential users

flow20tot=sum(flow20resid,1);
pat20singlehourtotDMA=cell(length(type),1);
for j=1:24    
    for i=1:length(type)
        indhour=find(timeflow20.Hour==j-1);
        indhour=indhour(find(daytype20==type(i)));
        pat20singlehourtotDMA{i}(:,j)=mean(flow20tot(:,indhour),2);     
    end
end


%Mean values of the patterns of the hourly consumption of the set of residential users
for i=1:length(type)
    day=daytime20(find(daytype20==type(i)));
        k=[];
    for j=1:length(day)
        k=[k, find(timeflow20.Day==day(j).Day & timeflow20.Month==day(j).Month)];
    end
    pat20meanhourtotDMA(:,i)=mean(flow20tot(:,k),2); 
end

%Patterns of the hourly consumption coefficients of the set of residential users

pat20adimhourtotDMA=cell(length(type),1);
for i=1:length(type)
    pat20adimhourtotDMA{i}=pat20singlehourtotDMA{i}(:,:)./pat20meanhourtotDMA(:,i);
end




%Patterns of the hourly consumption of every user
pat20singlehourresid=cell(length(type),1);
pat20singlehourcomm=cell(length(type),1);

for j=1:24
    
    for i=1:length(type)
        indhour=find(timeflow20.Hour==j-1);
        indhour=indhour(find(daytype20==type(i)));
        pat20singlehourcomm{i}(:,j)=mean(flow20comm(:,indhour),2);
        pat20singlehourresid{i}(:,j)=mean(flow20resid(:,indhour),2);
    end
end



%% PEAK COEFFICIENTS

%Peak consumption coefficients
for i=1:length(type)
        [peakcoeff20totDMA(i),hourpeakcoeff20totDMA(i)]=max(pat20adimhourtotDMA{i});
end

hourpeakcoeff20totDMA=hourpeakcoeff20totDMA-1;




      