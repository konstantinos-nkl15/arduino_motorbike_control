function [speed_In, I] = cruise_control(ref_speed , speed_out , Vmax , I , K_p , K_i ,step)
% Error
e = ref_speed  - speed_out;

% PID
I    = I + K_i * e * step;
v_in = K_p * e + I;

% Saturation
if v_in >= 0
    v_in = min(v_in,Vmax);
else
    v_in = max(v_in,-Vmax);
end
% Output
speed_In = v_in / Vmax;
end