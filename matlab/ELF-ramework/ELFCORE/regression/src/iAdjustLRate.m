function newLR =iAdjustLRate(learningRate, err)

%%
threshold = 0.05;
minErrThresh = 0.01;
divideLR = 2;
newLR = learningRate;
 
if length(err) < 3
    return;
end

if err(end) - err(end-1) < threshold ...
        && err(end-1) - err(end-2) < threshold...
        && err(end) < minErrThresh
    newLR = learningRate / divideLR;    
end

end