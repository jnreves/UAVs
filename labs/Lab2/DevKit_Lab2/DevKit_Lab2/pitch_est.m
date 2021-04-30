filename = 'EXP_C.mat';
[altitude_real,raw,euler, phys_accs,phys_gyros,altitude_vision, altitude_vz,navdata] =trata_dados(filename);
load(filename)
addpath ARDroneSimulinkDevKit_NAV\lib 


pitch_sim.A = 0;
pitch_sim.B = 1;
pitch_sim.C = 1;
pitch_sim.D = 0;
pitch_sim.G = 1;
pitch_sim.H = 0; 
pitch_sim.sys = ss(pitch_sim.A, [pitch_sim.B pitch_sim.G] ,pitch_sim.C, [pitch_sim.D pitch_sim.H] ) ;
tf(pitch_sim.sys)
pitch_sim.R = 4.9843e-05;

d1_iter = 30;

d1_high = 1.621e-09;
d1_low = 1.31e-09;
d1 = linspace(d1_low, d1_high, d1_iter);

d1(1) = 1.482e-9;
for i = 1:d1_iter
pitch_sim.Q = d1(i); 



Kest_pitch = kalman(pitch_sim.sys,pitch_sim.Q,pitch_sim.R);
tf_pitch = tf(Kest_pitch);


ARDroneReplay_V2_pitch ;
sim('ARDroneReplay_V2_pitch');

pitch_drone(i) = sim_pitch_drone;
pitch_hat(i) = sim_pitch_hat;
est_erros = pitch_drone(i).Data - pitch_hat(i).Data;
abs_est_erros = abs(est_erros);
avg_error(i) = mean(abs_est_erros);

figure(i)

plot(pitch_drone(i));
hold on
plot(pitch_hat(i));

end

figure()
plot(d1, avg_error);