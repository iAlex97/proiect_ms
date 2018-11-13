l1 = 2/4;
l2 = 3/4;

amp_u1 = 1;			% Amplitudine intrare treapta
amp_u2 = 1;			% Amplitudine intrare treapta
u2 = linspace(10, 100, 10); % Valori pentru amplitudinea treptei intrarii u2

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

animation_enable = 1; % porneste animatiile de nivel ale rezervoarelor
