function s = olChooseStyle(ind)

%%
width = 1;
style{1} = {'r-x','linewidth',width};
style{2} = {'g-h','linewidth',width};
style{3} = {'b-o','linewidth',width};
style{4} = {'c-*','linewidth',width};
style{5} = {'b-s','linewidth',width};
style{6} = {'k-d','linewidth',width};
style{7} = {'g-^','linewidth',width};
style{8} = {'m-s','linewidth',width};
style{9} = {'m-p','linewidth',width};
style{10} = {'y-o','linewidth',width};
style{11} = {'b-x','linewidth',width};
s = style{ind};
% set(gca,'FontName','Times New Roman','FontSize',20);

end
