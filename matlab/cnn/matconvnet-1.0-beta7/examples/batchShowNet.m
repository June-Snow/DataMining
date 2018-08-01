function batchShowNet(net_path)
net_path = './data/live-baseline/2014-12-07';
netfiles = dir(fullfile(net_path, '*.mat'));

figure(2);
for nfiles = 1 : length(netfiles)
    
    load(fullfile(net_path, netfiles(nfiles).name));
    
    for i=1:min(numel(net.layers), 2 ) %3层以后的filters平均显示没有意义
        ly = net.layers{i} ;
        if strcmp(ly.type, 'conv')
            l = size(ly.filters, 4);
            if size(net.layers{i}.filters,3) ~= 1
                ly.filters = mean(ly.filters,3);
            end
            f = ly.filters;
            sz = size(f);
            a = reshape(f, [sz(1)*sz(2)*sz(3) 1 sz(4)]);
            A = squeeze(a);
            display_network(A);
            title(sprintf('netpath is: %s, layer %d''s filters',...
                netfiles(nfiles).name, i));
            pause();
        end
        
    end
    
end