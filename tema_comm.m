%% functionname: function description
load_system(model_name)
res = sim(model_name,'StartTime','0','StopTime','500','FixedStep','0.2');
close_system(model_name)

h = res.h;
h1 = res.h1;
h2 = res.h2;
h3 = res.h3;
h4 = res.h4;

if (animation_enable == 1)
	animate_levels(h.Data, h1.Data, h2.Data, h3.Data, h4.Data);
else
	fprintf("Animatia este dezactivata.\n");
end

figure;

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