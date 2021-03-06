
sim_gyro.Data(isnan(sim_gyro.Data))=0;
gyro_cov = cov(sim_gyro.Data)
gyro_meanx = mean(sim_gyro.Data(:,1))
gyro_meany = mean(sim_gyro.Data(:,2))
gyro_meanz = mean(sim_gyro.Data(:,3))

plot(sim_acc.Time, sim_gyro.Data(:,1));
hold on
plot(sim_acc.Time, sim_gyro.Data(:,2));
plot(sim_acc.Time, sim_gyro.Data(:,3));
title('');


acc_cov = cov(sim_acc.Data)
acc_meanx = mean(sim_acc.Data(:,1))
acc_meany = mean(sim_acc.Data(:,2))
acc_meanz = mean(sim_acc.Data(:,3))

figure()
plot(sim_acc.Time, sim_acc.Data(:,1));
hold on
plot(sim_acc.Time, sim_acc.Data(:,2));
plot(sim_acc.Time, sim_acc.Data(:,3));


alt_ultrasound_cov = var(sim_alt_ultrasound.Data)
alt_ultrasound_mean = mean(sim_alt_ultrasound.Data)

figure()
plot(sim_acc.Time, sim_alt_ultrasound.Data);

alt_vision_cov = var(sim_alt_vision.Data)
alt_vision_mean = mean(sim_alt_vision.Data)

figure()
plot(sim_acc.Time, sim_alt_vision.Data);