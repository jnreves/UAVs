filename = 'EXP_B.mat';
[altitude_real,raw,euler, phys_accs,phys_gyros,altitude_vision, altitude_vz,navdata] =trata_dados(filename);
load(filename)
addpath ARDroneSimulinkDevKit_NAV\lib 


pitch_bias_sim.A = [0 -1; 0 0];
pitch_bias_sim.B = [1; 0];
pitch_bias_sim.C = [1 0];
pitch_bias_sim.D = 0;
pitch_bias_sim.G = eye(2);
pitch_bias_sim.H = [0 0]; 
pitch_bias_sim.sys = ss(pitch_bias_sim.A, [pitch_bias_sim.B pitch_bias_sim.G] ,pitch_bias_sim.C, [pitch_bias_sim.D pitch_bias_sim.H] ) ;
tf(pitch_bias_sim.sys)

added_bias =0.09;

for i = 1:1
pitch_bias_sim.Q = [0.00081 0; 0 0.00081]; 
%pitch_bias_sim.R = pitch_bias_sim.Q*2;
pitch_bias_sim.R = 25;

Kest_pitch = kalman(pitch_bias_sim.sys,pitch_bias_sim.Q,pitch_bias_sim.R);
tf_pitch = tf(Kest_pitch);


ARDroneReplay_V2_pitch_bias ;
sim('ARDroneReplay_V2_pitch_bias');

pitch_drone(i) = sim_pitch_drone.Data ;
pitch_hat(i) = sim_pitch_hat.Data(:, 1);
bias_hat = sim_pitch_hat.Data(:, 2);
est_erros(i) = pitch_drone(i) - pitch_hat(i);

figure(i+3)
plot(pitch_drone(i));
hold on
plot(pitch_hat(i));
hold off
legend('Real Pitch', 'Estimated Pitch')

figure(i+6)
plot(timeRT, added_bias * ones(1, length(bias_hat)))
hold on
plot(timeRT, bias_hat)
hold off
legend('Real Bias', 'Estimated Bias')


end