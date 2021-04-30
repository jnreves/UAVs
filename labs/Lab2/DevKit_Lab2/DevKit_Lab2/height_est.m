close all
clear all

filename = 'EXP_C.mat';
[altitude_real,raw,euler, phys_accs,phys_gyros,altitude_vision, altitude_vz,navdata] =trata_dados(filename);
load(filename)
addpath ARDroneSimulinkDevKit_NAV\lib 


height_sim.A = [0 1; 0 0];
height_sim.B = [0; 1];
height_sim.C = [1 0];
height_sim.D = 0;
height_sim.G = eye(2);
height_sim.H = [0 0]; 
% height_sim.R = 8.68e-5;
height_sim.R = 8.68e-7; 
height_sim.sys = ss(height_sim.A, [height_sim.B height_sim.G] ,height_sim.C, [height_sim.D height_sim.H] ) ;



% d1_iter = 5;
% 
% d1_high = 0.1;
% d1_low = 0.00000001;
% d1 = linspace(d1_low, d1_high, d1_iter);

% d1(1)=8.68e-5;
d1(1) = 0;


d2_iter = 1;

d2_high = 1000;
d2_low = 0.001;
d2 = linspace(d2_low, d2_high, d2_iter);

dims = combvec(d1, d2);



for i = 1:d2_iter
height_sim.Q = [ dims(1, i) 0; 0 dims(2, i)]; 
%height_sim.R = height_sim.Q*2;


%Kest_height = kalman(height_sim.sys,height_sim.Q,height_sim.R);
% tf_height = tf(Kest_height)


ARDroneReplay_V2_height ;
sim('ARDroneReplay_V2_height');

height_drone = sim_height_drone_real ;
height_hat = sim_height_hat;
est_erros = height_drone.Data - height_hat.Data;
abs_est_erros = abs(est_erros);
avg_error(i) = mean(abs_est_erros);

% figure()
% plot(height_drone);
% hold on
% plot(height_hat);
% plot(sim_alt_ultrasound_corrected);
% hold off
% legend('Real height', 'Estimated height',  'Altimeter Data')

% figure(i+12)
% plot(sim_vz_hat);
% hold on
% plot( altitude_vz);
% hold off



end

plot(d2, avg_error)
figure()
loglog(d2, avg_error)