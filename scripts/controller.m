clear;
clc;
%% Load Parameters
M = 400;
Jy = 1.17;
g = 9.81;

% Wheel
mw = 15/2.2;
Reff = 0.3;
Jw = (mw*Reff^2)/2;
B_bearing = 0.01;

% road profile
% c1 = 1.2801;  
% c2 = 23.99;
% c3 = 0.52;


% Brake parameters
% Wedge
Kcal = 6.8e6; % Brake pad stiffness
mu_cal = 0.3; % Brake friction coef.
Mw = 0.3; % Wedge mass
alpha = 12*pi/180; % angle of wedge

% Lead screw
eta = 0.9; %71-90% motor efficiency
L = 6; % Lead screw
% N = 24; % gear reduction

% Shaft
Jm = 0.01; % Shaft intertia
Kax = 750e6;
Dax = 9.3279e-5;

X0_caliper = 0.005; % Satuartion of the wedge distance from the disk

% DC Motor
L_m=0.5;
R_m=1;
K_m=0.01;

%% Symbolic 
syms  Xw Vw theta omega i_m real% States
syms Vin real% Inputs

%% Equations for the Plant

% State equations
dtheta = omega;
di_m = 1/L_m * (Vin-i_m*R_m-K_m*omega);
domega = 1/Jm * K_m * i_m;


%% States/Inputs/Outputs
x = [theta,omega,i_m]';
dx = [dtheta,domega,di_m]';
u = Vin;
y = omega;
%% Matrixification
A = double(jacobian(dx,x)); 
B = double(jacobian(dx,u));
C = double(jacobian(y,x));
D = double(jacobian(y,u));
%%
s = tf('s');

G_m = minreal(tf(ss(A,B,C,D))); % omega_m/Vin
zpk(G_m)

figure(1)
bodemag(G_m)
title('Angular rate to Voltage Bode')


tau = 0.001*2;
Y_omega = 1/G_m * 1/(tau*s+1)^3;
T_omega = minreal(Y_omega*G_m);
S_omega = 1 - T_omega;


Gc_omega = minreal(Y_omega*S_omega^(-1));

figure(2)
bodemag(T_omega,S_omega,Y_omega)
legend('T_w','S_w','Y_w')
title('Youla Design for the Angular rate controller')


%% 
dtheta  = omega;
F_M =  -(Kax*(Xw/cos(alpha)-theta*L/(2*pi))-...
         Dax*(Vw/cos(alpha)-omega*L/(2*pi)));

A1 = 1/(Mw*(1+tan(alpha)^2))*1/cos(alpha);
B1 = ((mu_cal-tan(alpha))*Kcal*tan(alpha))/(Mw*(1+tan(alpha)^2));

dVw = A1*F_M + B1* Xw;
dXw = Vw;


Fb = mu_cal*Kcal*Xw*tan(alpha);


%% States/Inputs/Outputs
x = [Vw,Xw,theta]';
dx = [dVw,dXw,dtheta]';
u = omega;
y = Fb;
%% Matrixification
A = double(jacobian(dx,x)); 
B = double(jacobian(dx,u));
C = double(jacobian(y,x));
D = double(jacobian(y,u));

G_b = minreal(tf(ss(A,B,C,D))); % Fb/omega
G = T_omega*G_b; % Fb/Vin

zpk(G)
figure(3)
bodemag(G)
title('Open-Loop transfer function Fb/Vin')


pole(G_b)
X1 =1.5546e-04 + 4.9996e+04i;
X2 =1.5546e-04 - 4.9996e+04i;

%%
syms wn k x;

tau = 0.01;
%wz = 5e4;

%T_sim = 1/(tau*x+1)^5 *(x^2+wz^2)/(x^2+wz*Q*x+wz^2);

T_sim = 1/(tau*x+1)^3 * wn^4/(x^2+2*k*wn*x+wn^2)^2; %* b/a * (x+a)/(x+b);

eqn1 = subs(T_sim,x,X1) == 1;
eqn2 = subs(T_sim,x,X2) == 1;
eqn3 = subs(T_sim,x,0) == 1;

[Sol_a,Sol_b] = solve(eqn1,eqn2,eqn3,wn>0,k>0,wn,k);

wn=eval(vpa(Sol_a))
k=eval(vpa(Sol_b))

wn = wn(1)
k = k(1)
%%

Y_b = 1/G * 1/(tau*s+1)^3 * wn^4/(s^2+2*k*wn*s+wn^2)^2;
T_b = 1/(tau*s+1)^3 * wn^4/(s^2+2*k*wn*s+wn^2)^2;

evalfr(T_b,X1)
evalfr(T_b,X2)
evalfr(T_b,0)

S_b = 1-T_b;

T_b = minreal(T_b);
S_b = minreal(S_b);

Gc_brake = minreal(Y_b*S_b^(-1));


figure
bodemag(T_b,S_b,Y_b)
legend('T_b','S_b','Y_b')
title('Youla Design for the force controller')


save controllers Gc_brake Gc_omega