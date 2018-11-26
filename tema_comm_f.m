%% functionname: function description
close all;
load_system(model_name);

loop_len = length(amp_var_u2);
% h2_out_sett_arr = [];
% h4_out_sett_arr = [];
error_sys_2 = ones(loop_len);
error_sys_4 = ones(loop_len);

import java.util.*;

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
			[A, B, C, D] = linmod(model_name, ...
					[h.Data(j) h1.Data(j) h2.Data(j) h3.Data(j) h4.Data(j)], ...
					[u1_data(j) u2_data(j)]);

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

for i=1:loop_len
	for j=1:loop_len
		keep_j = true
		for k=1:loop_len
			if (error_sys_2(k, j) <= error_sys_2(k, j) and k ~= i)
				keep_j = false
			end
		end
		if (keep_j)
			% keep_j here
		end
	end
end

close_system(model_name);