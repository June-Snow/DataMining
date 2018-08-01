function [feat, label] = iGetBatch(feature, label, batch)

%%
feat = feature(batch);

if ~isempty(label)
    label = label(batch) ;
end

end