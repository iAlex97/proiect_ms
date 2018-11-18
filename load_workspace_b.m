l1 = 2/4;
l2 = 3/4;

amp_u1 = 4;		% Amplitudine intrare treapta
amp_u2 = 4;		% Amplitudine intrare treapta

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

arr_cih1 = [0, 0.1, 0.2, 0.3, 0.4];
arr_cih2 = [0, 0.3, 0.2, 0.1, 0.5];
arr_cih3 = [0, 0.5, 0.8, 0.9, 0.2];
arr_cih4 = [0, 0.2, 0.4, 0.6, 0.8];
arr_cih  = [1, 0.8, 0.6, 0.4, 0.5];

a1 = 1.31 / 10^4;	% m^2
a2 = 1.51 / 10^4;	% m^2
a3 = 9.27 / 10^5;	% m^2
a4 = 8.82 / 10^5;	% m^2
ac = 4.307 / 10^6;	% m^2

step1 = 2; 			% V
step2 = 1;			% V
kp = 0.5 / 10^4;	% m^3/(s*V)

animation_enable = 0; % rulam mai multe simulari si ar durea prea mult