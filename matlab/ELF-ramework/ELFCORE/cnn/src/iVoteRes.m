function info = iVoteRes(info, res)

%% Vote Result
[~, ind] = max(res(end-1).x, [ ], 3);
train_vote = squeeze(ind)';
info.vote{end} = [info.vote{end}, train_vote];

end