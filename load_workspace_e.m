l1 = 2/4;
l2 = 3/4;

amp_u1 = 2;			% Amplitudine intrare treapta
amp_u2 = 4;			% Amplitudine intrare treapta
amp_var_u2 = linspace(1, 3, 30); % Valori pentru amplitudinea treptei intrarii u2

u1_time = 0:time_step:time_count;
u1_data = ones(1, length(u1_time)) * amp_u1;
u1 = [u1_time' u1_data'];

u2_time = 0:time_step:time_count;
u2_data = ones(1, length(u2_time)) * amp_u2;
u2 = [u2_time' u2_data'];

q = 1000;			% kg/m^3
g = 9.8; 			% m/s^2

A1 = 0.06;			% m^2
A2 = 0.06;			% m^2
A3 = 0.06;			% m^2
A4 = 0.06;			% m^2
AT = 0.1273;		% m^2

cih1 = 0;
cih2 = 0;
cih3 = 0;
cih4 = 0;
cih  = 1;

a1 = 1.31 / 10^4;	% m^2
a2 = 1.51 / 10^4;	% m^2
a3 = 9.27 / 10^5;	% m^2
a4 = 8.82 / 10^5;	% m^2
ac = 4.307 / 10^6;	% m^2

step1 = 2; 			% V
step2 = 1;			% V
kp = 0.5 / 10^4;	% m^3/(s*V)

animation_enable = 0; % porneste animatiile de nivel ale rezervoarelor
