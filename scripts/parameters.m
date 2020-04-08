%%
M = 400;
Jy = 1.17;
g = 9.81;

% Wheel
mw = 15/2.2;
Reff = 0.3;
Jw = (mw*Reff^2)/2;
B_bearing = 0.01;

% road profile
c1 = 1.2801;  
c2 = 23.99;
c3 = 0.52;


%% Brake parameters

%% Wedge
Kcal = 44.8385e6;%6.8e6;  % Caliper's stiffness
Kpad = 100*3.35e7; % Brake pad stiffness
mu_cal = 0.35; % Brake fdriction coef.
Mw = 0.3; % Wedge mass
alpha = 24.5*pi/180;%12*pi/180; % angle of wedge

%% Lead screw
% eta = 0.63; %71-90% motor efficiency
% L_screw = 3e-3; % Lead screw
% N = 1/24; % gear reduction

eta = 0.8; %71-90% motor efficiency
L_screw = 3e-3; % Lead screw
N = 1/24; % gear reduction

%% Shaft
Jm = 7.094e-3;

% Kax = 750e6;
% Dax = 9.3279e-5;

Kax = 750e6;
Dax = 9.3279e-5;

Dm = 1.9175e-5; % motor viscous friction
%Dm = 0.1;

X0_caliper = 0.005; % Satuartion of the wedge distance from the disk

% DC Motor

R_m = 0.4781;
L_m = 0.0230;
K_t = 0.0156;
K_e = 0.0158;
% R_m = 1; % Motor resistance
% L_m = 0.5; % Motor Inductance
% K_m = 0.01;




