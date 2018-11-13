function [] = animate_levels(h_data, h1_data, h2_data, h3_data, h4_data, A1, A2, A3, A4, AT)
	figure('units','normalized','outerposition',[0 0 1 1])

	sHandle1 = subplot(3, 2, 1);
	sHandle2 = subplot(3, 2, 2);
	sHandle3 = subplot(3, 2, 3);
	sHandle4 = subplot(3, 2, 4);
	sHandle5 = subplot(3, 2, 5);

	A_MAX = max([A1 A2 A3 A4 AT]);
	A_MIN = min([A1 A2 A3 A4 AT]);
	VOL_MAX = max([max(h_data * AT) max(h1_data * A1) max(h2_data * A2) ...
			max(h3_data * A3) max(h4_data * A4)]);
	H_MAX = VOL_MAX / A_MIN;

	for i=1:length(h_data);
		area(sHandle1, [(A_MAX - A1) / 2 (A_MAX + A1) / 2],[h1_data(i) h1_data(i)]);
		area(sHandle2, [(A_MAX - A2) / 2 (A_MAX + A2) / 2],[h2_data(i) h2_data(i)]);
		area(sHandle3, [(A_MAX - A3) / 2 (A_MAX + A3) / 2],[h3_data(i) h3_data(i)]);
		area(sHandle4, [(A_MAX - A4) / 2 (A_MAX + A4) / 2],[h4_data(i) h4_data(i)]);
		area(sHandle5, [(A_MAX - AT) / 2 (A_MAX + AT) / 2],[h_data(i) h_data(i)]);

		xlim(sHandle1, [0 A_MAX]);
		ylim(sHandle1, [0 H_MAX]);
		title(sHandle1, 'Nivel h1');

		xlim(sHandle2, [0 A_MAX]);
		ylim(sHandle2, [0 H_MAX]);
		title(sHandle2, 'Nivel h2');

		xlim(sHandle3, [0 A_MAX]);
		ylim(sHandle3, [0 H_MAX]);
		title(sHandle3, 'Nivel h3');

		xlim(sHandle4, [0 A_MAX]);
		ylim(sHandle4, [0 H_MAX]);
		title(sHandle4, 'Nivel h4');

		xlim(sHandle5, [0 A_MAX]);
		ylim(sHandle5, [0 H_MAX]);
		title(sHandle5, 'Nivel h');

		pause(.1);
	end
end