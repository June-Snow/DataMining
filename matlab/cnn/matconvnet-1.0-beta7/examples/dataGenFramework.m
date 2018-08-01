function dataGenFramework()
root = 'D:\STUDY\MachineLearning\ML°ü\matconvnet-1.0-beta7\matconvnet-1.0-beta7\examples\data\live';
opts.type = 'cnn';
opts.database = 'live';
opts = init_param(opts);

fn_dinfo = getDataInfoWrapper(root, opts);
[folders images] = fn_dinfo (root, opts);
fn_dmake = makeDataWrapper(folders, images, opts);
fn_dmake(folders, images, opts);


% -------------------------------------------------------------------------
function fn = getDataInfoWrapper(root, opts)
% -------------------------------------------------------------------------
switch opts.database
    case 'live'
        fn = @(root, opts) getTidInfo(root, opts);
    case 'tid'
        fn = @(root, opts) getLiveInfo(root, opts);
end


% -------------------------------------------------------------------------
function fn = makeDataWrapper(folders, images, opts)
% -------------------------------------------------------------------------
% E.G.: fn = @ (root, opts) makeCnnData(root, opts)
switch opts.type
    case 'cnn'
        fn = @(folders, images) makeCnnData(folders, images);
    case 'gbdt'
        fn = @(folders, images) makeGbdtData(folders, images);
end

% function [folders, images] = makeCnnData()

% function [] = makeGbdtData()

% -------------------------------------------------------------------------
function opts = init_param(opts)
% -------------------------------------------------------------------------
switch opts.database
    case 'live'
        
    case 'tid'
        opts.image_path = fullfile(opts.root, 'distorted_images');
        opts.mosfile_path = fullfile(opts.root, 'mos_with_names.txt');
end