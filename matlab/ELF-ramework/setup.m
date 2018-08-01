addpath('ELFCORE');
addpath(fullfile('ELFCORE', 'cnn')) ;
addpath(fullfile( 'ELFCORE', 'cnn', 'src')) ;
addpath(fullfile('ELFCORE', 'svm')) ;
addpath('ELFCTRL');
addpath('ELFFEATURE');
addpath(fullfile('ELFFEATURE', 'opticalflow'));
addpath(fullfile('ELFFEATURE', 'opticalflow', 'utils'));
addpath(fullfile('ELFFEATURE', 'opticalflow', 'utils', 'flowColorCode'));
addpath('ELFMAKEDATA');
addpath('ELFUI');
addpath('model');
addpath(fullfile('model', 'cnn'));
addpath('util');

run('util/util_setup.m');
run('ELFFEATURE/opticalflow/setup_of.m');