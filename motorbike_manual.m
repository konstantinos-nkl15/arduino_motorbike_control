%%motorbike_manual( m, s)
clc;
speed_In = 0;
angle_In = 0.5;
prompt = [0 0 0 0 0 0 0 0 0 0];
prompt(1)  = 'i';
fprintf( 'Motorbike ON: on\nSpeed : %.1f\nAngle : %.1f\n', speed_In, angle_In);
%power on
m.Speed = speed_In;
writePosition(s, angle_In);

start(m)
while (prompt(1) ~= 'q')
    prompt = input('','s');
%Speed Adjustment
    if prompt(1) == 't' && speed_In < 1
        speed_In = speed_In + 0.1;
    elseif prompt(1) == 'g' && speed_In > -1
        speed_In = speed_In -0.1;
    elseif prompt(1) == 'p'
        speed_In = 0;

%Steering adjustment
    elseif prompt(1) == 'f' && angle_In < 1
        angle_In = angle_In + 0.1;
    elseif prompt(1) == 'h' && angle_In > 0
        angle_In =max (0, angle_In - 0.1);
    end
    clc;
    m.Speed = speed_In;
    writePosition(s,angle_In);
% Speedometer Print    
    fprintf( 'Motorbike : ON\nSpeed : %.1f\nAngle : %.1f\n', speed_In, angle_In);
end

stop(m);
fprintf( 'Motorbike Q OFF\nSpeed : %.1f\nAngle : %.1f', speed_In, angle_In);
