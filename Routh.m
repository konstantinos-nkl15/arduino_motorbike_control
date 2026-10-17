function [decision,output] = Routh(c_e)

% Initialization
output = zeros(length(c_e) , ceil(length(c_e)/2));

for i = 1 :  (length(c_e) / 2 + 1)
    if((2 * i - 1) <= length(c_e))
        output(1,i) = c_e(2*i-1);
    else
        output(1,i) = 0;
    end
end
for i = 1 : (length(c_e))
    if(2*i <= length(c_e))
        output(2,i) = c_e(i*2);
    else
        output(2,i) = 0;
    end
end
output(1,1) = c_e(1);
output(2,1) = c_e(2);

% Main loop
for i=3 :length(c_e)
    for j = 1 : ( length( output(i-1,:) ) - 1 )
        A = [output(i-2,1) output(i-2,j+1);output(i-1,1) output(i-1,j+1)];
        output(i,j) = -det(A)/A(2,1);
    end
end
% Results
if( max(output(:,1)*min(output(:,1))) < 0)
    decision = 'unstable';
elseif ( max(output(:,1)*min(output(:,1))) > 0)
    decision = 'stable';
else
    decision = 'special case';
end
