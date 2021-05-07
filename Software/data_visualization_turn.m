clear all;
close all;

bl1 = readtable('Data/Turn/test1_fo_bl_90_turn.csv');
bl2 = readtable('Data/Turn/test2_fo_bl_90_turn.csv');
bl3 = readtable('Data/Turn/test3_fo_bl_90_turn.csv');

bs1 = readtable('Data/Turn/test4_fo_bs_90_turn.csv');
bs2 = readtable('Data/Turn/test5_fo_bs_90_turn.csv');
bs3 = readtable('Data/Turn/test3_fo_bs_90_turn.csv');

fs1 = readtable('Data/Turn/test1_fs_bl_90_turn.csv');
fs2 = readtable('Data/Turn/test2_fs_bl_90_turn.csv');
fs3 = readtable('Data/Turn/test3_fs_bl_90_turn.csv');

bl = cell2table(cell(273,10), 'VariableNames', bl1.Properties.VariableNames);
bs = cell2table(cell(268,10), 'VariableNames', bs1.Properties.VariableNames);
fs = cell2table(cell(256,10), 'VariableNames', fs1.Properties.VariableNames);

for var = bl.Properties.VariableNames
   bl.(var{1}) = (bl1.(var{1})+bl2.(var{1})(322-272:end)+bl3.(var{1})(288-272:end))./3; 
end

for var = bs.Properties.VariableNames
   bs.(var{1}) = (bs1.(var{1})+bs2.(var{1})(490-267:end)+bs3.(var{1})(302-267:end))./3; 
end

for var = fs.Properties.VariableNames
   fs.(var{1}) = (fs1.(var{1})+fs2.(var{1})(277-255:end)+fs3.(var{1})(263-255:end))./3; 
end

LAccel = sqrt(bl.LAccelX.^2 + bl.LAccelY.^2);
LAngle = cos(bl.LAccelX./bl.LAccelY);
RAccel = sqrt(bl.RAccelX.^2 + bl.RAccelY.^2);
RAngle = cos(bl.RAccelX./bl.RAccelY);
bl = [ table(LAccel, RAccel, LAngle, RAngle) bl];

LAccel = sqrt(bs.LAccelX.^2 + bs.LAccelY.^2);
LAngle = cos(bs.LAccelX./bs.LAccelY);
RAccel = sqrt(bs.RAccelX.^2 + bs.RAccelY.^2);
RAngle = cos(bs.RAccelX./bs.RAccelY);
bs = [ table(LAccel, RAccel, LAngle, RAngle) bs];

LAccel = sqrt(fs.LAccelX.^2 + fs.LAccelY.^2);
LAngle = cos(fs.LAccelX./fs.LAccelY);
RAccel = sqrt(fs.RAccelX.^2 + fs.RAccelY.^2);
RAngle = cos(fs.RAccelX./fs.RAccelY);
fs = [ table(LAccel, RAccel, LAngle, RAngle) fs];

Accel = (bl.LAccel + bl.RAccel)/2;
Angle = (bl.LAngle + bl.RAngle)/2;
bl = [table(Accel, Angle) bl];

Accel = (bs.LAccel + bs.RAccel)/2;
Angle = (bs.LAngle + bs.RAngle)/2;
bs = [table(Accel, Angle) bs];

Accel = (fs.LAccel + fs.RAccel)/2;
Angle = (fs.LAngle + fs.RAngle)/2;
fs = [table(Accel, Angle) fs];

figure()
subplot(4,1,1);
plot(bl.Accel)
title('Acceleration')
subplot(4,1,2);
plot(bl.Angle)
title('Angle')
subplot(4,1,3)
plot(bl.RSense1)
hold('on')
plot(bl.RSense2)
plot(bl.RSense3)
legend('Sense1','Sense2','Sense3')
title('Left Handle')
subplot(4,1,4)
plot(bl.LSense1)
hold('on')
plot(bl.LSense2)
plot(bl.LSense3)
legend('Sense1', 'Sense2', 'Sense3')
title('Right Handle')
sgtitle('Front Omni, Back Leg, 90 degree Turn')

figure()
subplot(4,1,1);
plot(bs.Accel)
title('Acceleration')
subplot(4,1,2);
plot(bs.Angle)
title('Angle')
subplot(4,1,3)
plot(bs.RSense1)
hold('on')
plot(bs.RSense2)
plot(bs.RSense3)
legend('Sense1', 'Sense2', 'Sense3')
title('Left Handle')
subplot(4,1,4)
plot(bs.LSense1)
hold('on')
plot(bs.LSense2)
plot(bs.LSense3)
legend('Sense1', 'Sense2', 'Sense3')
title('Right Handle')
sgtitle('Front Omni, Back Wheel, 90 Degree Turn')

figure()
subplot(4,1,1);
plot(fs.Accel)
title('Acceleration')
subplot(4,1,2);
plot(fs.Angle)
title('Angle')
subplot(4,1,3)
plot(fs.RSense1)
hold('on')
plot(fs.RSense2)
plot(fs.RSense3)
legend('Sense1', 'Sense2', 'Sense3')
title('Left Handle')
subplot(4,1,4)
plot(fs.LSense1)
hold('on')
plot(fs.LSense2)
plot(fs.LSense3)
legend('Sense1', 'Sense2', 'Sense3')
title('Right Handle')
sgtitle('Front Standard, Back Leg, 90 Degree Turn')