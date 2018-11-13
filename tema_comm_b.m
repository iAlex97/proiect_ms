%% functionname: function description
load_system(model_name);

figure(3);

loop_len = length(arr_cih);

out_arr2_data = zeros(100, loop_len);
out_arr4_data = zeros(100, loop_len);
out_arr_time  = zeros(100, loop_len);
out_data_len  = [];

for i=1:loop_len
	cih  = arr_cih(i);
	cih1 = arr_cih1(i);
	cih2 = arr_cih2(i);
	cih3 = arr_cih3(i);
	cih4 = arr_cih4(i);

	res = sim(model_name,'StartTime','0','StopTime','500','FixedStep','0.2');

	h  = res.h;
	h1 = res.h1;
	h2 = res.h2;
	h3 = res.h3;
	h4 = res.h4;

	out_data_len(end+1) = length(h.Time);
	out_arr2_data(1:out_data_len(i), i) = h2.Data;
	out_arr4_data(1:out_data_len(i), i) = h4.Data;
	out_arr_time(1:out_data_len(i), i)  = h.Time;

	if (animation_enable == 1)
		animate_levels(h.Data, h1.Data, h2.Data, h3.Data, h4.Data, A1, A2, A3, A4, AT);
	else
		fprintf("Animatia este dezactivata.\n");
	end
end

sHandle1 = subplot(2, 1, 1);
hold on;
for i=1:loop_len
	leg = sprintf("C = %.2f, C_1 = %.2f, C_2 = %.2f, C_3 = %.2f, C_4 = %.2f", arr_cih(i), arr_cih1(i), arr_cih2(i), arr_cih3(i), arr_cih4(i));
	plot(sHandle1, out_arr_time(1:out_data_len(i), i), out_arr2_data(1:out_data_len(i), i), 'DisplayName', leg);
end
hold off;

title(sHandle1, 'h2(t)');
xlabel(sHandle1, 'Timp (s)')
ylabel(sHandle1, 'Inaltime (m)');
legend show;

sHandle2 = subplot(2, 1, 2);
hold on;
for i=1:loop_len
	leg = sprintf("C = %.2f, C_1 = %.2f, C_2 = %.2f, C_3 = %.2f, C_4 = %.2f", arr_cih(i), arr_cih1(i), arr_cih2(i), arr_cih3(i), arr_cih4(i));
	plot(sHandle2, out_arr_time(1:out_data_len(i), i), out_arr4_data(1:out_data_len(i), i), 'DisplayName', leg);
end
hold off;

title(sHandle2, 'h4(t)');
xlabel(sHandle2, 'Timp (s)')
ylabel(sHandle2, 'Inaltime (m)');
legend show;

close_system(model_name);