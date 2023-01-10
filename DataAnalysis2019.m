%% Effects of the COVID-19 Lockdown on Water Consumptions: a Northern Italy Case Study
% Stefano Alvisi, Marco Franchini, Chiara Luciani, Irene Marzola, Filippo Mazzoni
% Note. This code has been developed and tested by using MATLAB® version R2019b.

%In this code the water consumptions from the period between the 4th of
%April and the 3th of May of 2019 are analyzed.

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


%% IMPORT OF DATA

%Data importation
dati=importdata('dataset2019.csv');

timevol=datetime(dati.textdata(:,2:end));
timevol=datetime(timevol, 'InputFormat','dd/MM/yy HH:mm','TimeZone','Europe/Rome');

vol=dati.data(:,2:end);     %cubic meter
matricole=dati.data(:,1);

clear dati

%% EXTRAPOLATION OF PERIOD 4th APRIL - 3th MAY OF 2019

%Selection of period 4th April - 4th May
indiniz=find(timevol.Hour==0 & timevol.Day==4 & timevol.Month==4);
indfine=find(timevol.Hour==0 & timevol.Day==4 & timevol.Month==5);

vol=vol(:,indiniz:indfine);
timevol=timevol(indiniz:indfine);

clear indiniz indfine

%Evaluation of flows
flow=zeros(length(matricole),length(timevol)-1);

for i=1:length(timevol)-1
    flow(:,i)=(vol(:,i+1)-vol(:,i))*1000;      % liter/hour
end

timeflow=timevol(1:end-1);


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
matrresid=matricole(indresid);
volresid=vol(indresid,:);
flowresid=flow(indresid,:);
matrcomm=matricole(indcommercial);
volcomm=vol(indcommercial,:);
flowcomm=flow(indcommercial,:);


%% DAY DIVISION

%Division of the days based on:
%0 weekdays
%1 saturdays
%2 sundays/holidays
%4 days not considered

data=importdata('day2019.xlsx');

daytime=datetime(data.textdata);
daytype=data.data; 
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

week2019=importdata('week2019.xlsx');


%% DAILY VOLUME AND AVERAGE DAILY VOLUME


%Daily volume of every users and every day of the monitored period 
ind=find(timevol.Hour==0);
for i=1:length(ind)-1 
voldayresid(:,i)=(volresid(:,ind(i+1))-volresid(:,ind(i)))*1000;   %liter
voldaycomm(:,i)=(volcomm(:,ind(i+1))-volcomm(:,ind(i)))*1000;   %liter
end

%Average daily volume of the set of residential/commercial users
volmeandaytotresid=mean(sum(voldayresid,1))/1000;  %cubic meter
volmeandaytotcomm=mean(sum(voldaycomm,1))/1000;  %cubic meter


%% WEEKLY PATTERN

voldaytotresid=sum(voldayresid,1);

%Average daily volume for each day of the week of the set of residential
%users

for i=1:7
    ind19=find(week2019==i);
    volweektotresid(i)=mean(voldaytotresid(ind19));
end


%% HOURLY PATTERN

%Patterns of the hourly consumption of the set of residential users

flowtot=sum(flowresid,1);
patsinglehourtotDMA=cell(length(type),1);
for j=1:24    
    for i=1:length(type)
        indhour=find(timeflow.Hour==j-1);
        indhour=indhour(find(daytype==type(i)));
        patsinglehourtotDMA{i}(:,j)=mean(flowtot(:,indhour),2);
    end
end

%Mean values of the patterns of the hourly consumption of the set of residential users
for i=1:length(type)
    day=daytime(find(daytype==type(i)));
        k=[];
    for j=1:length(day)
        k=[k, find(timeflow.Day==day(j).Day & timeflow.Month==day(j).Month)];
    end
    patmeanhourtotDMA(:,i)=mean(flowtot(:,k),2); 
end

%Patterns of the hourly consumption coefficients of the set of residential users

patadimhourtotDMA=cell(length(type),1);
for i=1:length(type)
    patadimhourtotDMA{i}=patsinglehourtotDMA{i}(:,:)./patmeanhourtotDMA(:,i);
end


%Patterns of the hourly consumption of every user
patsinglehourresid=cell(length(type),1);
patsinglehourcomm=cell(length(type),1);

for j=1:24
    
    for i=1:length(type)
        indhour=find(timeflow.Hour==j-1);
        indhour=indhour(find(daytype==type(i)));
        
        patsinglehourcomm{i}(:,j)=mean(flowcomm(:,indhour),2);
        patsinglehourresid{i}(:,j)=mean(flowresid(:,indhour),2);        
    end
end



%% PEAK COEFFICIENTS

%Peak consumption coefficients
for i=1:length(type)
        [peakcoefftotDMA(i),hourpeakcoefftotDMA(i)]=max(patadimhourtotDMA{i});
end
hourpeakcoefftotDMA=hourpeakcoefftotDMA-1;

