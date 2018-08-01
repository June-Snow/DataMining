net_path = './data/cifar-baseline/net-epoch-20.mat';
load(net_path);
layers = net.layers;
load('./data/cifar-baseline/imdb.mat');
normalization.averageImage = images.data_mean;
normalization.imageSize = size(normalization.averageImage);
classes = meta.classes;
save('cifar_net_vgg.mat', 'layers', 'normalization', 'classes');
