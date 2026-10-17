function [K, m_speed] = DC_motor_test_no_load(m, e, Vmax, Vset, timer, step)

steps = timer / step;
m_speed = zeros(steps, length(Vset));
dtime = zeros(steps, length(Vset));
for i = 1 : length(Vset)
    [m_speed(:,i),~,dtime(:,i)] = dcmotor_test( m, e, Vmax, Vset(i), timer, step);
end
idx = 1:steps;
plot(dtime(idx,:), m_speed(idx,:));
grid
xlabel('time (s)')
ylabel('Speed (rad/s)')
legend(compose('Vset = %g V', Vset))
title('Motor Speed Response - no load');

speed_Max = zeros(length(Vset),1);

for j = 1 : length(speed_Max)
   n = round(1/step);                                
speed_Max(j) = mean(m_speed(steps-n+1 : steps, j));
end
p = polyfit(Vset, speed_Max, 1);

spM = [];
v   = [];
for i = 1 : length(Vset)
    if speed_Max(i) > 0.08*max(speed_Max) && speed_Max(i) < 0.8*max(speed_Max)
        spM(end+1) = speed_Max(i);
        v(end+1)   = Vset(i);
    end
end

p2 = polyfit(v, spM, 1);
K  = p2(1);

figure(2);
y_fit1 = polyval(p,  Vset);
y_fit2 = polyval(p2, v);
plot(Vset, speed_Max, 'o-', Vset, y_fit1, v, y_fit2);
grid
xlabel('V (V)');
ylabel('Steady-state speed (rad/s)');
legend('S.S. Speed - Vset', 'Κ(Least Squares - Full Set)', 'K (Least Squares - Linear Region)');
title('Motor Speed Response - no load');
end