function [ learningRec ] = iUpdateRec( learningRec, rec )

%%
learningRec.objective(end) = rec.objective;
%learningRec.speed(end) = info.speed(end) + speed ;
learningRec.error(end) = learningRec.error(end) + rec.error ;
learningRec.vote{end} = [learningRec.vote{end}, rec.vote];

end

