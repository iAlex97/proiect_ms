%% functionname: function description
close all;
load_system(model_name);

loop_len = length(amp_var_u2);
% h2_out_sett_arr = [];
% h4_out_sett_arr = [];
error_sys_2 = ones(loop_len);
error_sys_4 = ones(loop_len);

j_queue = [];

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

	for k=1:length(h4.Data)
		if (h4.Time(k) >= res4.SettlingTime && h2.Time(k) >= res2.SettlingTime)
			[A, B, C, D] = linmod(model_name, ...
					[h.Data(k) h1.Data(k) h2.Data(k) h3.Data(k) h4.Data(k)], ...
					[u1_data(k) u2_data(k)]);

			linsys = ss(A, B, C, D);

			for j=1:loop_len
				amp_u2 = amp_var_u2(j);

				u2_time = 0:time_step:time_count;
				u2_data = ones(1, length(u2_time)) * amp_u2;
				u2 = [u2_time' u2_data'];

				res = sim(model_name,'StartTime','0','StopTime','300','FixedStep','0.02');

				h  = res.h;
				h1 = res.h1;
				h2 = res.h2;
				h3 = res.h3;
				h4 = res.h4;

				out = lsim(linsys, [u1_data; u2_data]', u1_time');

				ti = linspace(1, 300, 300);

				nonlinear_out_2 = interp1(h2.Time, h2.Data, ti);
				linear_out_2 = interp1(u2_time, out(:, 3), ti);

				nonlinear_out_4 = interp1(h4.Time, h4.Data, ti);
				linear_out_4 = interp1(u2_time, out(:, 5), ti);

				error_sys_2(i, j) = ...
						norm((linear_out_2 - nonlinear_out_2) ./ nonlinear_out_2);
				
				error_sys_4(i, j) = ...
						norm((linear_out_4 - nonlinear_out_4) ./ nonlinear_out_4);
			end

			[err_min, err_idx] = min(error_sys_2(i, :));
			fprintf("Eroare min la j: %d => u2 = %d\n", err_idx, amp_var_u2(err_idx));
			j_queue(i) = err_idx;

			pause(.1);
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

% for i=1:loop_len
% 	for j=1:loop_len
% 		keep_j = true;
% 		for k=1:loop_len
% 			if (error_sys_2(i, j) <= error_sys_2(k, j) && k ~= i)
% 				keep_j = false;
% 			end
% 		end
% 		if (keep_j)
% 			fprintf("idx j: %d\n", j);
% 			% keep_j here
% 		end
% 	end
% end

close_system(model_name);