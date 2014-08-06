function [uwarEn,wavEn, uwarRSE,wavRSE, uwarNumP,wavNumP, uwarMaxPV,wavMaxPV, uwarMaxPL,wavMaxPL, uwarSE,wavSE] = getWAVAndUWARFeatures(base)
%{
'audvoicingfeats/energy'
'audvoicingfeats/global_max_acorr_peak_lag'
'audvoicingfeats/global_max_acorr_peak_val'
'audvoicingfeats/global_min_acorr_peak_val'
'audvoicingfeats/lowfreqenergy'
'audvoicingfeats/max_acorr_peak_lag'
'audvoicingfeats/max_acorr_peak_val'
'audvoicingfeats/num_acorr_peaks'
'audvoicingfeats/rel_spec_entropy'
'audvoicingfeats/spec_entropy'
%}

uwarFile = [base '.uwar'];

uwarEn = uwar_io_getSensorData(uwarFile, 'audvoicingfeats/energy');
wavEn = readBinMat([base '.energy.bin']);


uwarRSE = uwar_io_getSensorData(uwarFile, 'audvoicingfeats/rel_spec_entropy');
wavRSE = readBinMat([base '.relspecent.bin']);

uwarNumP = uwar_io_getSensorData(uwarFile, 'audvoicingfeats/num_acorr_peaks');
wavNumP = readBinMat([base '.acorr01NumPeaks.bin']);

uwarMaxPV = uwar_io_getSensorData(uwarFile, 'audvoicingfeats/max_acorr_peak_val');
wavMaxPV = readBinMat([base '.acorr01MaxPeakVal.bin']);

uwarMaxPL = uwar_io_getSensorData(uwarFile, 'audvoicingfeats/max_acorr_peak_lag');
wavMaxPL = readBinMat([base '.acorr01MaxPeakLag.bin']);

uwarSE = uwar_io_getSensorData(uwarFile, 'audvoicingfeats/spec_entropy');
wavSE = readBinMat([base '.specent.bin']);
