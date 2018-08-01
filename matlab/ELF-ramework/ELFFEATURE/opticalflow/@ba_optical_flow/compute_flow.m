function uv = compute_flow(this, init)
%COMPUTE_FLOW   Compute flow field
%   UV = COMPUTE_FLOW(THIS[, INIT]) computes the flow field UV with
%   algorithm THIS and the optional initialization INIT.
%
%   This is a member function of the class 'ba_optical_flow'.

% Frame size
sz = [size(this.images, 1), size(this.images, 2)];

% If we have no initialization argument, initialize with all zeros
if (nargin < 2)
    uv = zeros([sz, 2]);
else
    uv = init;
end

% If there are fewer than 1 pyramid levels, default to 1
if (this.pyramid_levels < 1)
    this.pyramid_levels = 1;
end

% Construct image pyramid, using filter setting in Bruhn et al in "Lucas/Kanade.." (IJCV2005') page 218
smooth_sigma      = this.pyramid_spacing/2;
f                 = fspecial('gaussian', 2*round(1.5*smooth_sigma) +1, smooth_sigma);
pyramid_images    = compute_image_pyramid(this.images, f, this.pyramid_levels, 1/this.pyramid_spacing);

pyramid_levels = this.pyramid_levels;

% Iterate through all pyramid levels starting at the top
for l = pyramid_levels:-1:1
    
    if this.display
        disp(['-Pyramid level: ', num2str(l)])
    end
    
    % Generate copy of algorithm with single pyramid level and the
    % appropriate subsampling
    small = this;
    small.images = pyramid_images{l};
    nsz   = [size(pyramid_images{l}, 1) size(pyramid_images{l}, 2)];
    
    uv    =  resample_flow(uv, nsz);
    
    % Run flow method on subsampled images
    uv = compute_flow_base(small, uv, l);
end

end

