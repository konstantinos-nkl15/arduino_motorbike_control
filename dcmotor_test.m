function [speed, angle, dtime] = dcmotor_test( m, encoder, Vmax,Vset, timer, step,plots)

%resetCount(encoder);
speed_1 = Vset/Vmax;
%speed_2 = -Vset/Vmax;
steps = timer / step;
speed = zeros(steps, 1);
angle = zeros(steps, 1);
ts = NaT(steps, 1);
dtime = zeros(steps, 1);
m.Speed = speed_1;
start(m);
for i = 1 : steps
    pause(step);
    [angle(i), ts(i)] = readCount(encoder);
    angle(i) = angle(i)* (2 * pi) / 1200; 
end

stop(m);

for i = 2 : steps
speed(i) = (angle(i) - angle(i-1)) / seconds(ts(i)-ts(i-1));
dtime(i) = seconds(ts(i) - ts(1));
end

if plots == 1
    plot(dtime, speed);
    grid
    xlabel('time (s)')
    ylabel('Speed (rad/s)')
    legend(compose('Vset = %g V', Vset));
    title('Motor Speed Response - Loaded(Bike on Air)');
end
end