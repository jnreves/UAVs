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

added_bias =0;
exp_bias = 0.005;

d1_iter = 1;

d1_high = 0.1;
d1_low = 0.00000001;

d1 = linspace(d1_low, d1_high, d1_iter);


d2_iter = 5;

d2_high = 0.1;
d2_low = 0.00000001;
d2 = linspace(d2_low, d2_high, d2_iter);

dims = combvec(d1, d2);

for i = 1:(d1_iter*d2_iter)
pitch_bias_sim.Q = [ dims(1) 0; 0 dims(2)]; 
%pitch_bias_sim.R = pitch_bias_sim.Q*2;
pitch_bias_sim.R = 25;

Kest_pitch = kalman(pitch_bias_sim.sys,pitch_bias_sim.Q,pitch_bias_sim.R);
tf_pitch = tf(Kest_pitch);


ARDroneReplay_V2_pitch_bias ;
sim('ARDroneReplay_V2_pitch_bias');

pitch_drone = sim_pitch_drone.Data ;
pitch_hat = sim_pitch_hat.Data(:, 1);
bias_hat = sim_pitch_hat.Data(:, 2);
est_error_pitch = pitch_drone - pitch_hat;
abs_est_error_pitch = abs(est_error_pitch);
avg_error_pitch(i) = mean(abs_est_error_pitch);

est_error_bias = exp_bias - bias_hat;
abs_est_error_bias = abs(est_error_bias);
avg_error_bias(i) = mean(abs_est_error_bias);

figure()
plot(pitch_drone);
hold on
plot(pitch_hat);
hold off
legend('Real Pitch', 'Estimated Pitch')

figure()
plot(timeRT, exp_bias * ones(1, length(bias_hat)))
hold on
plot(timeRT, bias_hat)
hold off
legend('Real Bias', 'Estimated Bias')


end
% figure()
% plot3(dims(1, :), dims(2, :), avg_error_pitch)
% figure()
% plot3(dims(1, :), dims(2, :), avg_error_bias)