
filename = 'EXP_D.mat';
[altitude_real,raw,euler, phys_accs,phys_gyros,altitude_vision, altitude_vz,navdata] =trata_dados(filename);
load(filename)
addpath ARDroneSimulinkDevKit_NAV\lib 

ARDroneReplay_V2_inclinometer ;
sim('ARDroneReplay_V2_inclinometer');



plot(sim_pitch_inclinometer);
hold on
plot(sim_pitch_drone);
title("Inclinomter's pitch prediction vs Drone's pitch estimation in static case")

legend('Inclinometer', "Drone's pitch estimation");

inclinometer__mean = mean(sim_pitch_inclinometer.Data)

inclinometer_var =var(sim_pitch_inclinometer)