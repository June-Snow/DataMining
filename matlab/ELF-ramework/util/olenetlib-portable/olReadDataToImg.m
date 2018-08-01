function [img] = olReadDataToImg(datapath)

%%
[name, path, ext] = fileparts(datapath);
ext = olStdExt(ext);
switch ext
    case {'.bmp', '.jpg'}
        try
            da = imread(datapath);
        catch e
            da = zeros(256, 256);
            rethrow(e);
            warning(['Failed to read data.', datapath]);
        end
    case '.avi'        
         try
            v = VideoReader(datapath);
            da = read(v, 1);
         catch e
            da = zeros(256, 256);
            rethrow(e);
            warning(['Failed to read data.', datapath]);
         end
         v = version;
%          if strcmp(v(1:9), '8.3.0.532')
%              da = flipud(da);%¾ØÕóµÄ·­×ª
%          end

        %if olGetversion == 8.3
        %    da = flipud(da);
        %end
end

img = da;

end