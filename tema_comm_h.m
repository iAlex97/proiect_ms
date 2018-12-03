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

	for k=1:length(h4.Data)
		if (h4.Time(k) >= res4.SettlingTime && h2.Time(k) >= res2.SettlingTime)
			[A, B, C, D] = linmod(model_name, ...
					[h.Data(k) h1.Data(k) h2.Data(k) h3.Data(k) h4.Data(k)], ...
					[u1_data(k) u2_data(k)]);

			linsys{i} = ss(A, B, C, D);
			time_at(i) = h4.Time(k);
			state{i} = [h.Data(k) h1.Data(k) h2.Data(k) h3.Data(k) h4.Data(k)];

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

				out = lsim(linsys{i}, [u1_data; u2_data]', u1_time');

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

j_queue = [];

for i=1:loop_len
	for j=1:loop_len
		keep_j = true;
		for k=1:loop_len
			if (error_sys_2(k, j) <= error_sys_2(i, j) && k ~= i)
				keep_j = false;
			end
		end
		if (keep_j)
			j_queue(end + 1) = j;
		end
	end
end

% 
% compute the partial linear system response
% 
out_1 = [];
out_2 = [];
last_i = 1;
last_x = [cih cih1 cih2 cih3 cih4];
for it=1:length(j_queue)
	j = j_queue(it);
	t = time_at(j);
	current_u1_data = [];
	current_u2_data = [];
	current_time = [];

	amp_u2 = amp_var_u2(j);
	u2_time = 0:time_step:time_count;
	u2_data = ones(1, length(u2_time)) * amp_u2;
	u2 = [u2_time' u2_data'];

	while (u1_time(last_i) < t)
		current_time(end + 1) = u1_time(last_i);
		current_u1_data(end + 1) = u1_data(last_i);
		current_u2_data(end + 1) = u2_data(last_i);
		last_i = last_i + 1;
	end
	[out, last_t, last_x] = lsim(linsys{j}, [current_u1_data; current_u2_data]', ...
			current_time', last_x(end, :));

	out_1 = [out_1; out(:, 3)];
	out_2 = [out_2; out(:, 5)];
end

% add the last part of the signal
current_u1_data = [];
current_u2_data = [];
current_time = [];

amp_u2 = amp_var_u2(j);
u2_time = 0:time_step:time_count;
u2_data = ones(1, length(u2_time)) * amp_u2;
u2 = [u2_time' u2_data'];

while (last_i <= length(u1_time))
	current_time(end + 1) = u1_time(last_i);
	current_u1_data(end + 1) = u1_data(last_i);
	current_u2_data(end + 1) = u2_data(last_i);
	last_i = last_i + 1;
end

out = lsim(linsys{j}, [current_u1_data; current_u2_data]', ...
		current_time', [last_x(end, :)]);

% don't  really know why but I missed an element
out_1 = [out_1; out(:, 3)];
out_2 = [out_2; out(:, 5)];

% concatenate the result:
ti = linspace(1, 300, 300);

length(out_1)
length(u2_time)

nonlinear_out_2 = interp1(h2.Time, h2.Data, ti);
partial_linear_out_2 = interp1(u2_time, out_1, ti);

nonlinear_out_4 = interp1(h4.Time, h4.Data, ti);
partial_linear_out_4 = interp1(u2_time, out_2, ti);

figure(1);
shandle1 = subplot(1, 1, 1);

hold on;
plot(shandle1, ti, nonlinear_out_2, 'r');
plot(shandle1, ti, partial_linear_out_2, 'g');
hold off;

title(shandle1, 'y2');
legend('original', 'linear');

figure(2);
shandle2 = subplot(1, 1, 1);

hold on;
plot(shandle2, ti, nonlinear_out_4, 'r', 'DisplayName', 'original');
plot(shandle2, ti, partial_linear_out_4, 'b', 'DisplayName', 'linear aprox');
hold off;

title(shandle2, 'y4');
legend('original', 'linear');

fun = @(i) abs(nonlinear_out_2(ceil(i)) - partial_linear_out_2(ceil(i)));
quad(fun, ti(1), ti(end))

fun = @(i) abs(nonlinear_out_4(ceil(i)) - partial_linear_out_4(ceil(i)));
quad(fun, ti(1), ti(end))

close_system(model_name);