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
height_sim.sys = ss(height_sim.A, [height_sim.B height_sim.G] ,height_sim.C, [height_sim.D height_sim.H] ) ;



for i = 1:1
height_sim.Q = [0 0; 0 0.005]; 
%height_sim.R = height_sim.Q*2;
height_sim.R = 0.005/150;

Kest_height = kalman(height_sim.sys,height_sim.Q,height_sim.R);
tf_height = tf(Kest_height)


ARDroneReplay_V2_height ;
sim('ARDroneReplay_V2_height');

heigh_drone(i) = sim_height_drone_real ;
height_hat(i) = sim_height_hat;
est_erros(i) = heigh_drone(i) - height_hat(i);

figure(i+9)
plot(heigh_drone(i));
hold on
plot(height_hat(i));
plot(sim_alt_ultrasound_corrected);
hold off
legend('Real height', 'Estimated height',  'Altimeter Data')

% figure(i+12)
% plot(sim_vz_hat);
% hold on
% plot( altitude_vz);
% hold off



end