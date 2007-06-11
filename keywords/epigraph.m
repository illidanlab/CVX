function epigraph( varargin )
error( nargchk( 0, Inf, nargin ) );

%EPIGRAPH Declare an epigraph cvx variable.
%   EPIGRAPH VARIABLE x
%   where x is a valid MATLAB variable name, declares a scalar
%   variable for the current cvx problem, and specifies it as
%   the objective of a minimization. There is no need to declare
%   a separate MINIMIZE command.
%
%   This keyword should be used only when attempting to
%   create a new function for the CVX library. Suppose you have a
%   function F(X) whose epigraph {(X,Y)}{F(X)<=Y} can be
%   described as a CVX feasibiliy problem. Then declaring Y
%   as an EPIGRAPH turns the model into one that computes the
%   value of the function itself, minimizing over Y.
%
%   Other uses of this keyword are NOT supported and can lead
%   to numerical errors.
%
%   EPIGRAPH VARIABLE x(n1,n2,...,nk)
%   declares a vector, matrix, or array epigraph variable with
%   dimensions n1, n2, ..., nk, each of which must be positive
%   integers.
%
%   Structure modifiers such as "symmetric", "toeplitz", etc.
%   are permitted with epigraph variables.
%
%   Examples:
%      epigraph variable x
%      epigraph variable x(100)
%
%   See also VARIABLE, HYPOGRAPH.

if ~iscellstr( varargin ),
    error( 'EPIGRAPH must be used in command mode.' );
elseif nargin < 2 | ~isequal( varargin{1}, 'variable' ),
    error( 'Syntax: epigraph variable <variable>' );
else
    evalin( 'caller', sprintf( '%s ', 'variable', varargin{2:end}, ' epigraph_' ) );
end

% Copyright 2005 Michael C. Grant and Stephen P. Boyd.
% See the file COPYING.txt for full copyright information.
% The command 'cvx_where' will show where this file is located.