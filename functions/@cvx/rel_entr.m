function cvx_optval = rel_entr( x, y )

%REL_ENTR   Internal cvx version.

global cvx___
if ~cvx___.expert,
    error( sprintf( 'Disciplined convex programming error:\n    Relative entropy is not yet supported.' ) );
end

persistent remap_x remap_y remap_z
error( nargchk( 2, 2, nargin ) );
sx = size( x ); xs = all( sx == 1 );
sy = size( y ); ys = all( sy == 1 );
if xs,
    sz = sy;
elseif ys,
    sz = sx;
elseif ~isequal( sx, sy ),
    error( 'Dimensions are not compatible.' );
end
if ~cvx___.expert,
    error( sprintf( 'Disciplined convex programming error:\n    Entropy functions are not yet supported.' ) );
end

% 0 : invalid
% 1 : negative constant x
% 2 : zero x
% 3 : positive constant x
% 4 : concave x
if isempty( remap_z ),
    remap_1 = cvx_remap( 'real' );
    remap_2 = cvx_remap( 'real-affine' ) & ~remap_1;
    remap_3 = cvx_remap( 'concave' )     & ~remap_1;
    remap_x = remap_1 + 2 * remap_2;
    remap_y = remap_1 + 2 * remap_3;
    remap_z = ...
        [ 0, 0, 0 ; ...
          0, 1, 2 ; ...
          0, 2, 2 ];
end
vx = remap_x( cvx_classify( x ) );
vy = remap_y( cvx_classify( y ) );
vr = remap_z( vx + 3 * vy + 1 );

%
% Perform the computations for each expression type separately
%

vu = unique( vr );
nv = length( vu );
sx = size( x );
xt = x;
yt = y;
if nv ~= 1,
    y = cvx( sx, [] );
end
for k = 1 : nv,

    %
    % Select the category of expression to compute
    %

    vk = vu( k );
    if nv ~= 1,
        t = vr == vk;
        if ~xs, xt = cvx_subsref( x, t ); sz = size( xt ); end
        if ~ys, yt = cvx_subsref( y, t ); sz = size( yt ); end
    end

    %
    % Perform the computations
    %

    switch vk,
        case 0,
            % Invalid
            error( sprintf( 'Disciplined convex programming error:\n    Illegal operation: rel_entr( {%s}, {%s} ).', cvx_class( xt, true, true ), cvx_class( yt, true, true ) ) );
        case 1,
            % Constant
            cvx_optval = rel_entr( cvx_constant( xt ), cvx_constant( yt ) );
        case 2,
            % Real affine
            cvx_begin
                epigraph variable q( sz );
                { -q, xt, yt } == exponential( sz );
            cvx_end
        otherwise,
            error( 'Shouldn''t be here.' );
    end

    %
    % Store the results
    %

    if nv == 1,
        y = cvx_optval;
    else
        y = cvx_subsasgn( y, t, cvx_optval );
    end

end

% Copyright 2007 Michael C. Grant and Stephen P. Boyd.
% See the file COPYING.txt for full copyright information.
% The command 'cvx_where' will show where this file is located.