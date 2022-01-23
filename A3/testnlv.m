% computing the spreading of influenza
% test for Newton's on one (large) timestep

% beta transmission, gamma recovery, mu death/birth (replenishment)
alpha = 1/6; beta = 0.25; gamma = 0.06; mu = 0.01/365; rho = 300*mu;
%rho = 0;

% initial conditions
N = 38e6; y02 = 20e3; y03 = 30e3; y04 = 850e3;
y0 = [N-y02-y03-y04 y02 y03 y04 0]';

dt = 1/2; % stepsize for time is h (or dt)
Alpha = dt*alpha;
Beta = dt*beta/N; 
Gamma = dt*gamma; 
Mu = dt*mu; 
Rho = dt*rho; % for convenience

maxit = 10; tol = 1e-6; % Newton's parameters
fprintf(' k   S         E      I       R          V     Total     Residual\n');
y = y0;
yinit = y; % initial guess for Newton's
for k = 1:maxit
    % define vector f and its inf norm
    f = [(1+Mu+Rho)*y(1)+Beta*y(1)*y(3)-yinit(1)-Mu*N;
        (1+Alpha+Mu)*y(2)-Beta*y(1)*y(3)-yinit(2);
        -Alpha*y(2)+(1+Gamma+Mu)*y(3)-yinit(3);
        -Gamma*y(3)+(1+Mu)*y(4)-yinit(4);
        -Rho*y(1)+(1+Mu)*y(5)-yinit(5)];
    fnorm =max(abs(f));
    fprintf('%2d %10.0f %6.0f %6.0f %9.0f %6.0f %10.0f %9.2e\n', ...
            k-1, y, sum(y), fnorm);
    % stopping criterion
    if fnorm <= tol
        break
    end
    % define Jacobian matrix
    J = [1+Mu+Rho+Beta*y(3) 0 Beta*y(1) 0 0;
        -Beta*y(3) 1+Alpha+Mu -Beta*y(1) 0 0;
        0 -Alpha 1+Gamma+Mu 0 0;
        0 0 -Gamma 1+Mu 0;
        -Rho 0 0 0 1+Mu];
    % apply Newton's iteration to compute new y
    y = y + J\(-f);
end