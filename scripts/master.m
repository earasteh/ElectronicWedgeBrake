clear;
clc;
close all;
%% Parameters
%Vehicle
parameters
% controller

load controllers
%% Initial conditions for the vehicle
u0 = 60; % Initial forward velocity
pu0 = M*u0;
pw0 = Jy*(u0/Reff);

inits = [pw0;pu0];

%% Simulate
tfinal = 10;


%Kcal = 6.8e6;
sim('Test_actuator')
simout_OL3=simout_OL;

%Kcal = 8e6; 
% sim('Test_actuator')
% simout_OL2=simout_OL;
% 
% %Kcal = 4e6; 
% sim('Test_actuator')
% simout_OL1=simout_OL;

%% Plots

% figure
% hold on
% plot(simout_OL1.Fb)
% plot(simout_OL2.Fb)
% plot(simout_OL3.Fb)
% legend('8e6 N/m','6.8e6 N/m','4e6 N/m')
% xlim([0 0.2])
% grid on;
% ylabel('Brake Force (N)')
% xlabel('Time (Sec.)')
% % cd plots

% 
figure(1)
hold on
yyaxis right
plot(simout_OL.Fb/mu_cal)
ylim([-1e5 2e5])
ylabel('Normal Froce, F_n (N)')
yyaxis left
plot(simout_OL.input)
ylabel('Input Voltage, V_m (V)')
ylim([0 15])
xlim([0 10])
grid on
legend('V_m','F_n')
% ylabel('Braking Force (N)')
% xlabel('Time (Sec.)')
% title('Braking Force')
saveas(gcf,'OL.png')
% 
% 
% figure(2)
% hold on
% plot(simout_OL.Xw*100)
% plot(simout_CL.Xw*100)
% xlim([0 0.5])
% 
% legend('Open-Loop (24 Volts)','Closed-Loop')
% ylabel('Wedge Displacement (cm)')
% xlabel('Time (Sec.)')
% title('Wedge Displacement')
% saveas(gcf,'Xw.png')





% figure
% plot(t,omega)
% xlabel('Time (Sec.)')
% ylabel('Wheel angular velocity (rad/Sec)')
% saveas(gcf,'omega.png')
% 
% figure
% plot(t,u)
% xlabel('Time (Sec.)')
% ylabel('Forward velocity (m/Sec.)')
% title('Forward Velocity of the Vehicle')
% saveas(gcf,'fwd.png')
% 
% 
% figure
% hold on;
% plot(t,tau_b)
% plot(t,tau_ref)
% xlabel('Time (Sec.)')
% ylabel('\tau_{brake}')
% legend('\tau','\tau_{ref}')
% saveas(gcf,'Brakeforce.png')




% cd ../
