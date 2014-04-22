

function [TPR, FPR, ACC, Precision, Recall, confusion_matrix] = compute_evaluation_metric (final_label_array, inference_result_array)

    
    % Reference: http://www.math.dartmouth.edu/~mqed/UNR/MedicalTesting/MedicalTesting_z65.pdf
    TP = 0; % True Positives: those who test positive and are positive
    TN = 0; % True Negatives: those who test negative and are negative
    FP = 0; % False Positives: those who test positive, but are negative
    FN = 0; % False Negatives: those who test negative, but are positive

    for index = 1:length(final_label_array)

        if (final_label_array(index) == 1) && (inference_result_array(index) == 1)
            TP = TP + 1;
        elseif (final_label_array(index) == 0) && (inference_result_array(index) == 0)
            TN = TN + 1;
        elseif (final_label_array(index) == 0) && (inference_result_array(index) == 1)
            FP = FP + 1;
        elseif (final_label_array(index) == 1) && (inference_result_array(index) == 0)
            FN = FN + 1;
        else
            fprintf('Should not reach here! Sth wrong!\n');
        end
        
        % DEBUG
        % fprintf('I am here!\n');

    end

    % Reference: http://en.wikipedia.org/wiki/Sensitivity_and_specificity
    % Reference: http://stats.stackexchange.com/questions/75045/calculating-precision-recall-curve-from-error-matrix-in-matlab
    
    % NOTE: The best 2 evaluation metric combination is {TPR, FPR}.
    % In case there is no voiced frame in the audio clip, TPR == NaN. In
    % this case, only FPR is useful.
    
    % TPR: true positive rate (sensitivity), equivalent to Recall.
    TPR = TP / (TP + FN);
    TPR = TPR * 100;
    % FPR: false positive rate
    FPR = FP / (FP + TN);
    FPR = FPR * 100;
    % ACC: accuracy
    ACC = (TP + TN) / (TP + TN + FP + FN);
    ACC = ACC * 100;
    % Precision
    Precision = TP / (TP + FP);
    Precision = Precision * 100;
    % Recall
    Recall = TP / (TP + FN);
    Recall = Recall * 100;
    % Confusion Matrix
    confusion_matrix = confusionmat(final_label_array, inference_result_array);
    
    
    
    