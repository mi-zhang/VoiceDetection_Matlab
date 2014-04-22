


% combine the voiced window feature values from all speech trials.
voiced_window_feature_array_speech = [];

voiced_window_feature_array_speech = [voiced_window_feature_array_speech; main_matlab_check_dynamic_window('speech_t2')];
voiced_window_feature_array_speech = [voiced_window_feature_array_speech; main_matlab_check_dynamic_window('speech_t3')];
voiced_window_feature_array_speech = [voiced_window_feature_array_speech; main_matlab_check_dynamic_window('speech_t4')];

% plot the histograms
figure;
subplot(2,1,1)
hist(voiced_window_feature_array_speech(:,1), 20);
xlabel('Mean Values of LF / HF Ratio (log10)');
axis tight
subplot(2,1,2)
hist(voiced_window_feature_array_speech(:,2), 20);
xlabel('STD Values of LF / HF Ratio (log10)');
axis tight
% put a single title for all subplots
ha = axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0 1],'Box','off','Visible','off','Units','normalized', 'clipping' , 'off');
text(0.5, 1, ['Speech: LF / HF Ratio: 500Hz'], 'HorizontalAlignment','center', 'VerticalAlignment','top');

% save the plot
saveas(gcf, ['speech_500Hz_energy_ratio'], 'jpg');   

voiced_window_feature_array_radio = main_matlab_check_dynamic_window('radio_t1');

% combine the voiced window feature values from all classical music trials.
voiced_window_feature_array_classical = [];

voiced_window_feature_array_classical = [voiced_window_feature_array_classical; main_matlab_check_dynamic_window('classical_t1')];
voiced_window_feature_array_classical = [voiced_window_feature_array_classical; main_matlab_check_dynamic_window('classical_t2')];
voiced_window_feature_array_classical = [voiced_window_feature_array_classical; main_matlab_check_dynamic_window('classical_t3')];
voiced_window_feature_array_classical = [voiced_window_feature_array_classical; main_matlab_check_dynamic_window('classical_t4')];

% plot the histograms
figure;
subplot(2,1,1)
hist(voiced_window_feature_array_classical(:,1), 20);
xlabel('Mean Values of LF / HF Ratio (log10)');
axis tight
subplot(2,1,2)
hist(voiced_window_feature_array_classical(:,2), 20);
xlabel('STD Values of LF / HF Ratio (log10)');
axis tight
% put a single title for all subplots
ha = axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0 1],'Box','off','Visible','off','Units','normalized', 'clipping' , 'off');
text(0.5, 1, ['Classical: LF / HF Ratio: 500Hz'], 'HorizontalAlignment','center', 'VerticalAlignment','top');

% save the plot
saveas(gcf, ['classical_500Hz_energy_ratio'], 'jpg');   

% combine the voiced window feature values from all vocal music trials.
voiced_window_feature_array_pop = [];

voiced_window_feature_array_pop = [voiced_window_feature_array_pop; main_matlab_check_dynamic_window('pop_t1')];
voiced_window_feature_array_pop = [voiced_window_feature_array_pop; main_matlab_check_dynamic_window('pop_t2')];
voiced_window_feature_array_pop = [voiced_window_feature_array_pop; main_matlab_check_dynamic_window('pop_t3')];
voiced_window_feature_array_pop = [voiced_window_feature_array_pop; main_matlab_check_dynamic_window('pop_t4')];
voiced_window_feature_array_pop = [voiced_window_feature_array_pop; main_matlab_check_dynamic_window('pop_t5')];
voiced_window_feature_array_pop = [voiced_window_feature_array_pop; main_matlab_check_dynamic_window('pop_t6')];

% plot the histograms
figure;
subplot(2,1,1)
hist(voiced_window_feature_array_pop(:,1), 20);
xlabel('Mean Values of LF / HF Ratio (log10)');
axis tight
subplot(2,1,2)
hist(voiced_window_feature_array_pop(:,2), 20);
xlabel('STD Values of LF / HF Ratio (log10)');
axis tight
% put a single title for all subplots
ha = axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0 1],'Box','off','Visible','off','Units','normalized', 'clipping' , 'off');
text(0.5, 1, ['Pop: LF / HF Ratio: 500Hz'], 'HorizontalAlignment','center', 'VerticalAlignment','top');

% save the plot
saveas(gcf, ['pop_500Hz_energy_ratio'], 'jpg');   

% plot the scatter plot
figure;
scatter(voiced_window_feature_array_speech(:,1), voiced_window_feature_array_speech(:,2), 50, 'o', 'MarkerEdgeColor', 'r');
hold on;
scatter(voiced_window_feature_array_classical(:,1), voiced_window_feature_array_classical(:,2), 50, '*', 'MarkerEdgeColor', 'b');
xlabel('Mean');
ylabel('STD');
legend('Speech', 'Classical')
title(['Speech vs. Classical Scatter Plot: 500Hz']);
axis tight

% save the plot
saveas(gcf, ['speech_classical_scatter_plot_500Hz'], 'jpg');    

figure;
scatter(voiced_window_feature_array_speech(:,1), voiced_window_feature_array_speech(:,2), 50, 'o', 'MarkerEdgeColor', 'r');
hold on;
scatter(voiced_window_feature_array_pop(:,1), voiced_window_feature_array_pop(:,2), 50, 'd', 'MarkerEdgeColor', 'g');
xlabel('Mean');
ylabel('STD');
legend('Speech', 'Pop')
title(['Speech vs. Pop Music Scatter Plot: 500Hz']);
axis tight

% save the plot
saveas(gcf, ['speech_pop_scatter_plot_500Hz'], 'jpg');    

figure;
scatter(voiced_window_feature_array_pop(:,1), voiced_window_feature_array_pop(:,2), 50, 'd', 'MarkerEdgeColor', 'g');
hold on;
scatter(voiced_window_feature_array_classical(:,1), voiced_window_feature_array_classical(:,2), 50, '*', 'MarkerEdgeColor', 'b');
xlabel('Mean');
ylabel('STD');
legend('Pop', 'Classical')
title(['Pop vs. Classical Music Scatter Plot: 500Hz']);
axis tight

% save the plot
saveas(gcf, ['pop_classical_scatter_plot_500Hz'], 'jpg');    


fprintf('I am done!\n');



