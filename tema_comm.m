%% functionname: function description
l1 = 2/4;
l2 = 3/4;

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

Q1 = 3.26; 			% m^3/s
Q2 = 4;				% m^3/s
kp = 0.5 / 10^4;	% m^3/(s*V)

load_system(model_name)
res = sim(model_name,'StartTime','0','StopTime','500','FixedStep','0.2');
close_system(model_name)

h = res.h;
h1 = res.h1;
h2 = res.h2;
h3 = res.h3;
h4 = res.h4;

animate_levels(h.Data, h1.Data, h2.Data, h3.Data, h4.Data);


figure(2)

subplot(2, 1, 1);
plot(h2.Time, h2.Data)

title('h2(t)');
xlabel('Timp (s)')
ylabel('Inaltime (m)');

subplot(2, 1, 2);
plot(h4.Time, h4.Data)

title('h4(t)');
xlabel('Timp (s)')
ylabel('Inaltime (m)');