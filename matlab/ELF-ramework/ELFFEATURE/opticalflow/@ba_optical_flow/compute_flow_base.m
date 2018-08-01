function uv = compute_flow_base(this, uv, l)
%COMPUTE_FLOW_BASE   Base function for computing flow field
%   UV = COMPUTE_FLOW_BASE(THIS, INIT) computes the flow field UV with
%   algorithm THIS and the initialization INIT.
%
%   This is a member function of the class 'ba_optical_flow'.
%%
% Construct quadratic formulation
qua_this          = this;
qua_this.lambda   = this.lambda_q;

% Spatial
for m = 1:length(this.rho_spatial_u)
    qua_this.rho_spatial_u{m}   = robust_function('quadratic', this.rho_spatial_u{m}.param);
    qua_this.rho_spatial_v{m}   = robust_function('quadratic', this.rho_spatial_v{m}.param);
end;

% Data
qua_this.rho_data = robust_function('quadratic', this.rho_data.param);


% Iterate flow computation
for i = 1:this.max_iters
    
    % Print status information
    if this.display
        disp(['--Iteration: ', num2str(m)]);
    end;
    
    duv = zeros(size(uv));
    % Compute spatial and temporal partial derivatives
    [It, Ix, Iy] = partial_deriv(this.images, uv, this.interpolation_method, this.deriv_filter);
      
    [A, b] = flow_operator(qua_this, uv, duv, It, Ix, Iy);
    
    if l >= 2
        x = reshape(A \ b, size(uv));           % 反斜杠
    else
%     [x, flag] = pcg(A, b, [], 10);     %  预条件共轭梯度法
        [x, flag] = cgs(A, b, [], 10);       % 共轭梯度平方法
        x = reshape(x, size(uv));
    end
    
    % If limiting the incremental flow to [-1, 1] is requested, do so
    if (this.limit_update)
        x(x > 1)  = 1;
        x(x < -1) = -1;
    end
    duv = x;
    
    % Update flow fileds
    uv = uv + duv;
    
end