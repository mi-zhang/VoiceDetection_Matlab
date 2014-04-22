================================
Evaluation Procedure:
================================

0. Plot the spectrograms.

1. Determine the best noise level and RSE window size altogether. 
- run: script_matlab_check_RSE_noise_level.m 
- Observations: 
(1) noise level must be >= 1%
(2) RSE window size must be >= 30
(3) RSE window size no differences when RSE window size is >= 200
(4) noise level is most effective when it equals to 1%, 2%, 3%, 4%
- Final parameter setup: RSE window size = 30, noise level = 2%

2. Plot the inference results (layer 1) and true labels under the best noise level and RSE window size.
- run: script_matlab_check_inference_result.m
- run: script_matlab_check_inference_result_for_each_window.m
- Test Results: 
+ Cases with high false positive rates:
ambient_t3: F1 car chasing
ambient_t5: Dror knocked on the wall
ambient_t6: Dror knocked on the table and on the window

bodysound_t4: Dror's snoring sound
bodysound_t7: Andrew's coughing sound

classical_t1: 
classical_t2:
classical_t3: 
classical_t4: 

pop_t1: pop 
pop_t2: pop
pop_t3: folk
pop_t4: Andrew's rock with male voice and the background music of the song played by the saxophone.
pop_t5: Andrew's jazz with piano and without human voice
pop_t6: Dror's pop music with a female chorus

tv_t1: Andrew's tv commercials (backgrond music + human voice)
tv_t2: Andrew's tv commercials + tv interview
tv_t3: Andrew's tv commercials (backgrond music + human voice)
tv_t4: tv interview
tv_t5: Dror's charlie rose
tv_t6: monologue

+ Cases with low true positive rates:
speech_t2: conversation between Andrew and his student

3. Plot the scatter plots (LF / HF ratio vs. Voiced Likelihood)
- set up the definition of LH / HF ratio at audio_feature_extraction.m
+ 4 options: 300Hz, 500Hz, 1KHz, and 2KHz
- run: script_matlab_check_energy_ratio_likelihood_scatter_plot.m 
- Observations: 
(1) For speech, the voiced likelihood always >= -4. Most of the speech has voiced likelihood >= -2.
(2) For non-speech, some are < -4. A number of them < -2.

4. Determine the best voiced likelihood threshold. 
- run: script_matlab_check_likelihood_true_positive_rate.m 
- Observations: 
(1) There are huge differences in terms of TPR values between -1, -2, and -3. 
That indicates most of the speech frames have voiced likelihood >= -3 (in unit of log10). 
- run: script_matlab_check_likelihood_false_positive_rate.m 
- Observations: 
(1) For TV, Pop, Ambient, BodySound, there are huge differences in terms of FPR values between -1, -2, and -3.
That indicates most of the non-speech frames have voiced likelihood >= -3 (in unit of log10). 
(1) For Classical Music, FPR values keep decreasing when likelihood threshold value increases.
That indicates a big portion of the non-speech frames have voiced likelihood <= -3 (in unit of log10). 
- By setting up voiced likelihood threshold >= -2, the following cases are resolved:
bodysound_t4: Dror's snoring sound
- By setting up voiced likelihood threshold >= -2, the following cases are resolved:
NONE!
- Final parameter setup: voiced likelihood threshold = -1, -2

5. Determine the best LH / HF ratio threshold. 
- set up the definition of LH / HF ratio at audio_feature_extraction.m
+ 4 options: 300Hz, 500Hz, 1KHz, and 2KHz










