model = 'tema';

l1 = 1/4;
l2 = 3/4;

q = 1000;			% kg/m^3
g = 9.8; 			% m/s^2

A1 = 0.06;			% m^2
A2 = 0.06;			% m^2
A3 = 0.06;			% m^2
A4 = 0.06;			% m^2
AT = 0.1273;		% m^2

a1 = 1.31 / 10^4;	% m^2
a2 = 1.51 / 10^4;	% m^2
a3 = 9.27 / 10^5;	% m^2
a4 = 8.82 / 10^5;	% m^2
ac = 4.307 / 10^6;	% m^2

Q1 = 3.26; 			% m^3/s
Q2 = 4;				% m^3/s
kp = 0.5 / 10^4;	% m^3/(s*V)

load_system(model)
sim(model,'StartTime','0','StopTime','50','FixedStep','0.2')

plot(dh2.Time, dh2.Data)