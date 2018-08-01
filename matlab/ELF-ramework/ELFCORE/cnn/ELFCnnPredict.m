function [pred, prop, speed, model] = ELFCnnPredict(model, feature, trainType )

%%
model = pre_proc_model(model);
batch_time = tic ;
epsilon = 1e-12;
nSample = length(feature);
feed = iFeature2DFeed(feature);
layerRet = vl_simplenn(model, feed) ;
pred = iRet2Pred(layerRet(end).x, trainType) ;
prop = {layerRet(end).x};
batch_time = toc(batch_time) ;
speed = numel(feature)/batch_time ;

end


function model = pre_proc_model(model)
%%
model = loss2soft_max(model);
model = rm_drop_out(model);
end


function model = loss2soft_max(model)
%%
model.layers{end}.type = 'softmax';
end

%%
function model = rm_drop_out(model)
%%
for i = 1 : length(model.layers)
    if strcmp(model.layers{i}.type, 'dropout')
        model.layers{i} = [];
    end
end
model.layers(cellfun('isempty',model.layers))=[];

end