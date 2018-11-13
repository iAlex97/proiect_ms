function [] = animate_levels(h_data, h1_data, h2_data, h3_data, h4_data, A1, A2, A3, A4, AT)
	figure('units','normalized','outerposition',[0 0 1 1])

	sHandle1 = subplot(3, 2, 1);
	sHandle2 = subplot(3, 2, 2);
	sHandle3 = subplot(3, 2, 3);
	sHandle4 = subplot(3, 2, 4);
	sHandle5 = subplot(3, 2, 5);

	for i=1:length(h_data);
		area(sHandle1, [(AT - A1) / 2 (AT + A1) / 2],[h1_data(i) h1_data(i)]);
		area(sHandle2, [(AT - A2) / 2 (AT + A2) / 2],[h2_data(i) h2_data(i)]);
		area(sHandle3, [(AT - A3) / 2 (AT + A3) / 2],[h3_data(i) h3_data(i)]);
		area(sHandle4, [(AT - A4) / 2 (AT + A4) / 2],[h4_data(i) h4_data(i)]);
		area(sHandle5, [(AT - AT) / 2 (AT + AT) / 2],[h_data(i) h_data(i)]);

		xlim(sHandle1, [0 AT]);
		ylim(sHandle1, [0 1.2]);
		title(sHandle1, 'Nivel h1');

		xlim(sHandle2, [0 AT]);
		ylim(sHandle2, [0 1.2]);
		title(sHandle2, 'Nivel h2');

		xlim(sHandle3, [0 AT]);
		ylim(sHandle3, [0 1.2]);
		title(sHandle3, 'Nivel h3');

		xlim(sHandle4, [0 AT]);
		ylim(sHandle4, [0 1.2]);
		title(sHandle4, 'Nivel h4');

		xlim(sHandle5, [0 AT]);
		ylim(sHandle5, [0 1.2]);
		title(sHandle5, 'Nivel h');

		pause(.1);
	end
end