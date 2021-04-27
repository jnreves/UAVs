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

for i = 1:3
pitch_sim.Q = 0.00081; 
%pitch_sim.R = pitch_sim.Q*2;
pitch_sim.R = 25;

Kest_pitch = kalman(pitch_sim.sys,pitch_sim.Q,pitch_sim.R);
tf_pitch = tf(Kest_pitch);


ARDroneReplay_V2_pitch ;
sim('ARDroneReplay_V2_pitch');

pitch_drone(i) = sim_pitch_drone;
pitch_hat(i) = sim_pitch_hat;
est_erros(i) = pitch_drone(i) - pitch_hat(i);

figure(i)

plot(pitch_drone(i));
hold on
plot(pitch_hat(i));

end