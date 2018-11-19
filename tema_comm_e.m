%% functionname: function description
close all;
load_system(model_name);

loop_len = length(amp_var_u2);
h2_out_sett_arr = [];
h4_out_sett_arr = [];
error_sys_2 = [];
error_sys_4 = [];

for i=1:loop_len
	amp_u2 = amp_var_u2(i);

	u2_time = 0:time_step:time_count;
	u2_data = ones(1, length(u2_time)) * amp_u2;
	u2 = [u2_time' u2_data'];

	res = sim(model_name,'StartTime','0','StopTime','300','FixedStep','0.02');

	h  = res.h;
	h1 = res.h1;
	h2 = res.h2;
	h3 = res.h3;
	h4 = res.h4;

	res2 = stepinfo(h2.Data, h2.Time);
	res4 = stepinfo(h4.Data, h4.Time);

	for j=1:length(h4.Data)
		if (h4.Time(j) >= res4.SettlingTime && h2.Time(j) >= res2.SettlingTime)
			fprintf("Here the simulation will start ...");
			[A, B, C, D] = linmod(model_name, ...
					[h.Data(j) h1.Data(j) h2.Data(j) h3.Data(j) h4.Data(j)], ...
					[u1_data(j) u2_data(j)]);

			linsys = ss(A, B, C, D);
			out = lsim(linsys, [u1_data; u2_data]', u1_time');

			ti = linspace(1, 300, 300);

			% why 2 ?????
			nonlinear_out_2 = interp1(h2.Time, h2.Data * 2, ti);
			linear_out_2 = interp1(u2_time, out(:, 3), ti);

			% why 2 ?????
			nonlinear_out_4 = interp1(h4.Time, h4.Data * 2, ti);
			linear_out_4 = interp1(u2_time, out(:, 5), ti);

			error_sys_2(end + 1) = ...
					norm((linear_out_2 - nonlinear_out_2) ./ nonlinear_out_2);
			
			error_sys_4(end + 1) = ...
					norm((linear_out_4 - nonlinear_out_4) ./ nonlinear_out_4);
			
			pause(.1);
			% out
			% h_all_out_sett_lin_arr(end + 1) = out;
			break;
		end
	end
	
	% break;

	if (animation_enable == 1)
		animate_levels(h.Data, h1.Data, h2.Data, h3.Data, h4.Data, A1, A2, A3, A4, AT);
	else
		fprintf("Animatia este dezactivata.\n");
	end
end

figure(1);
hold on;
plot(amp_var_u2, error_sys_2);
plot(amp_var_u2, error_sys_4);
hold off;

title('err');
legend('err_{y2}', 'err_{y4}');
% sHandle1 = subplot(2, 1, 1);
% stem(amp_var_u2, h2_out_sett_arr);
% cftool(amp_var_u2, h2_out_sett_arr);

% title(sHandle1, 'h2(t)');
% xlabel(sHandle1, 'Amplitudine u_2');
% ylabel(sHandle1, 'y_{stat}');
% legend show;

% sHandle2 = subplot(2, 1, 2);
% stem(amp_var_u2, h4_out_sett_arr);
% cftool(amp_var_u2, h4_out_sett_arr);

% title(sHandle2, 'h4(t)');
% xlabel(sHandle2, 'Amplitudine u_2');
% ylabel(sHandle2, 'y_{stat}');
% legend show;


close_system(model_name);