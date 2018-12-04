%% functionname: function description
close all;
load_system(model_name);

figure(4);

loop_len = length(amp_var_u2);
h2_out_sett_arr = [];
h4_out_sett_arr = [];

for i=1:loop_len
	amp_u2 = amp_var_u2(i);

	u2_time = 0:time_step:time_count;
	u2_data = ones(1, length(u2_time)) * amp_u2;
	u2 = [u2_time' u2_data'];

	res = sim(model_name,'StartTime','0','StopTime','300','FixedStep','0.2');

	h  = res.h;
	h1 = res.h1;
	h2 = res.h2;
	h3 = res.h3;
	h4 = res.h4;

	res2 = stepinfo(h2.Data, h2.Time);
	res4 = stepinfo(h4.Data, h4.Time);

	for j=1:length(h2.Data)
		if (h2.Time(j) >= res2.SettlingTime)
			h2_out_sett_arr(end+1) = h2.Data(j);
			break;
		end
	end

	for j=1:length(h4.Data)
		if (h4.Time(j) >= res4.SettlingTime)
			h4_out_sett_arr(end+1) = h4.Data(j);
			break;
		end
	end

	if (animation_enable == 1)
		animate_levels(h.Data, h1.Data, h2.Data, h3.Data, h4.Data, A1, A2, A3, A4, AT);
	else
		fprintf("Animatia este dezactivata.\n");
	end
end

sHandle1 = subplot(2, 1, 1);
plot(amp_var_u2, h2_out_sett_arr);
cftool(amp_var_u2, h2_out_sett_arr);

title(sHandle1, 'h2(t)');
xlabel(sHandle1, 'Amplitudine u_2');
ylabel(sHandle1, 'y_{stat}');
legend show;

sHandle2 = subplot(2, 1, 2);
plot(amp_var_u2, h4_out_sett_arr);
cftool(amp_var_u2, h4_out_sett_arr);

title(sHandle2, 'h4(t)');
xlabel(sHandle2, 'Amplitudine u_2');
ylabel(sHandle2, 'y_{stat}');
legend show;


close_system(model_name);