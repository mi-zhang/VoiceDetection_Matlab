function [] = compareExamples(ex1, ex2)

figure;

subplot(241), plot(ex1.signal);
subplot(242), imagesc(flipud(ex1.acorrgram'));
subplot(243), imagesc(flipud(20*log(ex1.specgram')));
subplot(244), imagesc((ex1.melspec'));

subplot(245), plot(ex2.signal);
subplot(246), imagesc(flipud(ex2.acorrgram'));
subplot(247), imagesc(flipud(20*log(ex2.specgram')));
subplot(248), imagesc((ex2.melspec'));

% figure(1);
% subplot(211), imagesc(newTraindata(1).acorrgram); hold on; plot((newTraindata(1).truth'-1)*100)
% subplot(212), imagesc(newTraindata(1).specgram); hold on; plot((newTraindata(1).truth'-1)*100)
% figure(2);
% subplot(211), imagesc(newTraindata(2).acorrgram); hold on; plot((newTraindata(2).truth'-1)*100)
% subplot(212), imagesc(newTraindata(2).specgram); hold on; plot((newTraindata(2).truth'-1)*100)
% figure(3);
% subplot(211), imagesc(newTraindata(3).acorrgram); hold on; plot((newTraindata(3).truth'-1)*100)
% subplot(212), imagesc(newTraindata(3).specgram); hold on; plot((newTraindata(3).truth'-1)*100)
%figure(4);
%subplot(211), imagesc(newTraindata(4).acorrgram); hold on; plot((newTraindata(4).truth'-1)*100)
%subplot(212), imagesc(newTraindata(4).specgram); hold on;
%plot((newTraindata(4).truth'-1)*100)