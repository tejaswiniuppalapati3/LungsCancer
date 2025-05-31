% Assuming the values from the hypothetical confusion matrix
confusionMatrix = [
    194.17, 0.83, 0.00, 0.00;
    0.00, 114.21, 0.79, 0.00;
    0.00, 0.00, 154.33, 0.67;
    0.00, 0.00, 0.00, 147.17
];

% Convert to percentages
confusionMatrixPercent = confusionMatrix ./ sum(confusionMatrix, 2) * 100;

% Class names for your diseases
classNames = {'Ischemia', 'Peripheral Artery', 'Aortic', 'Coronary Artery'};

% Display confusion matrix
figure;
imagesc(confusionMatrixPercent);
colormap(flipud(turbo));
colorbar;

% Set axis labels and ticks
xticks(1:length(classNames));
yticks(1:length(classNames));
xticklabels(classNames);
yticklabels(classNames);

% Label axes
xlabel('Predicted');
ylabel('Actual');
title('Confusion Matrix');

% Display values in each cell
for i = 1:length(classNames)
    for j = 1:length(classNames)
        text(j, i, sprintf('%.2f%%', confusionMatrixPercent(i, j)), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle');
    end
end

% Compute accuracy, specificity, and sensitivity
totalSamples = sum(confusionMatrix(:));
truePositives = diag(confusionMatrix);
falsePositives = sum(confusionMatrix, 1) - truePositives;
falseNegatives = sum(confusionMatrix, 2) - truePositives;

accuracy = sum(truePositives) / totalSamples * 100;
specificity = sum(diag(confusionMatrix) ./ sum(confusionMatrix, 1)) / length(classNames) * 100;
sensitivity = sum(diag(confusionMatrix) ./ sum(confusionMatrix, 2)) / length(classNames) * 100;

% Display accuracy, specificity, and sensitivity in the command window
fprintf('Accuracy: %.2f%%\n', accuracy);
fprintf('Specificity: %.2f%%\n', specificity);
fprintf('Sensitivity: %.2f%%\n', sensitivity);
