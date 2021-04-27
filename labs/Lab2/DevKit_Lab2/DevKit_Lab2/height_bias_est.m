filename = 'EXP_C.mat';
[altitude_real,raw,euler, phys_accs,phys_gyros,altitude_vision, altitude_vz,navdata] =trata_dados(filename);
load(filename)
addpath ARDroneSimulinkDevKit_NAV\lib 

height_sim.A = [0 1 0; 0 0 -1; 0 0 0];
height_sim.B = [0; 1; 0];
height_sim.C = [1 0 0];
height_sim.D = 0;
height_sim.G = eye(3);
height_sim.H = [0 0 0]; 
height_sim.sys = ss(height_sim.A, [height_sim.B height_sim.G] ,height_sim.C, [height_sim.D height_sim.H] ) ;

added_bias = 0.0009;

for i = 1:1
height_sim.Q = [0 0 0; 0 0.005 0; 0 0 0.0001]; % explain the bias covariance
%height_sim.R = height_sim.Q*2;
height_sim.R = 0.005/150;

Kest_height = kalman(height_sim.sys,height_sim.Q,height_sim.R);
tf_height = tf(Kest_height)


ARDroneReplay_V2_height_bias ;
sim('ARDroneReplay_V2_height_bias');

heigh_drone(i) = sim_height_drone_real ;
height_hat(i) = sim_height_hat;
bias_hat(i) = sim_bias_hat;
est_erros(i) = heigh_drone(i) - height_hat(i);

figure(i+15)
plot(heigh_drone(i));
hold on
plot(height_hat(i));
plot(sim_alt_ultrasound_corrected);
hold off
legend('Real height', 'Estimated height',  'Altimeter Data')

figure(i+18)
plot(bias_hat(i).Time, added_bias * ones(1, length(bias_hat(i).Time)))
hold on
plot(bias_hat(i))
hold off
legend('Real Bias', 'Estimated Bias')



end