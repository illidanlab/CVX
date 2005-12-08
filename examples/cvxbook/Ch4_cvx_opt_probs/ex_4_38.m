% EX_4_38.M      LMIs and SDPs with one variable
% Exercise 4.38 b), Boyd & Vandenberghe "Convex Optimization"
% Jo�lle Skaf - 09/26/05
%
% Finds the optimal t that would maximize c*t while still having A - t*B 
% positive semidefinite by solving the following SDP: 
%           minimize    c*t 
%               s.t.    t*B <= A 
% c can either be a positive or negative real number

cvx_quiet(false);
% Input data
randn('state',0);
n = 4;
A = randn(n); A = 0.5*(A'+A); %A = A'*A;
B = randn(n); B = B'*B;

% can modify the value of c (>0 or <0)
c = -1;
fprintf(1,'Computing the optimal t ... ');

cvx_begin
    variable t
    minimize ( c*t )
    (A - t*B) == semidefinite(n)
cvx_end

fprintf(1,'Done! \n');

% Displaying results
disp('------------------------------------------------------------------------');
disp('The optimal t obtained is');
disp(t);