function line = procData4ML(img, score, varargin)
%%
p = inputParser;

defaultType = 'whole';
expectedType = {'whole','block'};

addParameter(p,'type', defaultType, ...
    @(x) any(validatestring(x,expectedType)));

parse(p,varargin{:});
r = p.Results;

switch r.type
    case 'block',
        fun = @(block)(max(block.data(:)));
        data = blockproc(img, [28 28], fun);
        [M N ~] = size(data);
        data = reshape(data, [1 M*N]);
                
        line = [num2str(score) ' '];
        for i = 1 : length(data)
            line = [line num2str(i-1) ':' num2str(data(i)) ' '];
        end        
        line = [line '\n'];
        
    case 'whole',
        data = img(:);
        
        line = [num2str(score) ' '];
        for i = 1 : length(data)
            line = [line num2str(i-1) ':' num2str(data(i)) ' '];
        end
        line = [line '\n'];
end

end
