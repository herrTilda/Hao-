
load('Simon_muscle.mat')
load('Simon_fat.mat')

% from Dalla Man
load('EGP_dalla.mat');
load('S_dalla.mat');
load('pi_dalla.mat');
load('pg_dalla.mat');
load('Ra_dalla.mat');

% molar mass glucose = 180.156 g/mol

% mooreLiver =  180.156*[median([]),25,27.8]*10^3/10^(-6);
% gerichLiver = 180.156*[median([]),25,27.8]*10^3/10^(-6);

% 0.5044 - 1.9998 mg·kg?1·min?1

t = Simon_muscle(:,1);

y1 = Simon_muscle(:,2)/1000*0.65;  %muscle tissue glucose uptake in unit: mg/kg/min
SEM1 = Simon_muscle(:,3)/1000*0.65;%SEM of muscle tissue glucose uptake
y2 = Simon_fat(:,2)/1000*0.47;     %adipose tissue glucose uptake in unit: mg/kg/min
SEM2 = Simon_fat(:,3)/1000*0.47;   %SEM of adipose tissue glucose uptake

DATA = [];

DATA.EGP = EGP_dalla(:,2);
DATA.S = S_dalla(:,2);
DATA.pi = pi_dalla(:,2);
DATA.pg = pg_dalla(:,2);
DATA.Ra = Ra_dalla(:,2);
DATA.Muscle = y1;
DATA.Adipose = y2;

DATA.time = t;
DATA.SEM1 = SEM1;
DATA.SEM2 = SEM2;
DATA.SEM3 = 1;

save 'DATA_all.mat' DATA;