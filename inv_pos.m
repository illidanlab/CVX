function y = inv_pos( x )

% INV_POS   Inverse of a positive quantity.
%     For a real scalar X, INV_POS(X) returns 1/X if X is positive, and
%     +Inf otherwise.
%
%     For matrices and N-D arrays, the function is applied to each element.
%
%     Disciplined convex programming information:
%         INV_POS is convex and nonincreasing; therefore, when used in CVX
%         specifications, its argument must be concave (or affine).

error( nargchk( 1, 1, nargin ) );
if ~isreal( x ),

    error( 'Input must be real.' );

else

    y = 1.0 ./ max( x, 0 );

end

% Copyright 2007 Michael C. Grant and Stephen P. Boyd.
% See the file COPYING.txt for full copyright information.
% The command 'cvx_where' will show where this file is located.