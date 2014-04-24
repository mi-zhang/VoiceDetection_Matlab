function [] = computeAndSaveVoicingRSEMaxPNumP01(hmmfile, featurefile, pathfile)

h = load(hmmfile);

d = load(featurefile);
features = origAcorrRSEMaxPNumP01(d.data);

voicing = compute_voiced_path(features, h.hmm);

save(pathfile, 'voicing');
