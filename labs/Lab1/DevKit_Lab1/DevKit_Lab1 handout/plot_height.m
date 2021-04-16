matrix_name ='height_step_3_2_0_2.mat';
sim_time = 15;

states_exp = load(matrix_name);

all_time_axis = states_exp.states.time;
all_heigh_axis = states_exp.states.signals.values(:, 9);

plot(all_time_axis, all_heigh_axis);
hold on
plot(sim_variables.h__m_);

xlabel('time [s]');
ylabel('height [m]');

legend('experimental','simulation')

title('Experimental results vs Simulation results with Gain = 0.5, Cumulative Step = 1 m');
