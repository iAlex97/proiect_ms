function [] = animate_levels(h_data, h1_data, h2_data, h3_data, h4_data)
	figure('units','normalized','outerposition',[0 0 1 1])

	sHandle1 = subplot(3, 2, 1);
	xlim(sHandle1, [0 1]);
	ylim(sHandle1, [0 0.01]);
	title(sHandle1, 'Nivel h1');

	sHandle2 = subplot(3, 2, 2);
	xlim(sHandle2, [0 1]);
	ylim(sHandle2, [0 0.01]);
	title(sHandle2, 'Nivel h2');

	sHandle3 = subplot(3, 2, 3);
	xlim(sHandle3, [0 1]);
	ylim(sHandle3, [0 0.01]);
	title(sHandle3, 'Nivel h3');

	sHandle4 = subplot(3, 2, 4);
	xlim(sHandle4, [0 1]);
	ylim(sHandle4, [0 0.01]);
	title(sHandle4, 'Nivel h4');

	sHandle5 = subplot(3, 2, 5);
	xlim(sHandle4, [0 1]);
	ylim(sHandle4, [0 1.2]);
	title(sHandle4, 'Nivel h');

	for i=1:length(h_data);
		area(sHandle1, [0 1],[h1_data(i) h1_data(i)]);
		area(sHandle2, [0 1],[h2_data(i) h2_data(i)]);
		area(sHandle3, [0 1],[h3_data(i) h3_data(i)]);
		area(sHandle4, [0 1],[h4_data(i) h4_data(i)]);
		area(sHandle5, [0 1],[h_data(i) h_data(i)]);

		pause(.1);
	end
end