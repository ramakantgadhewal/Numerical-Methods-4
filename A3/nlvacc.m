% computing the spreading of influenza

% 1/alpha incubation
% beta transmission, gamma recovery, mu death/birth (replenishment)
% rho vaccination
alpha = 1/6; beta = 0.25/4; gamma = 0.06; mu = 0.01/365; rho = 300*mu;

% initial conditions
N = 38e6; y02 = 20e3; y03 = 30e3; y04 = 850e3;
y0 = [N-y02-y03-y04 y02 y03 y04 0]';

% time span
%tend = 365;

% scenarios
%rho = 0;      beta = 0.25;   tend = 150; study = '(c)'; % (c)
%rho = 300*mu; beta = 0.25;   tend = 365; study = '(d)'; % (d)
rho = 300*mu; beta = 0.25/4; tend = 365; study = '(e)'; % (e)
fprintf('study %s\n', study);

dt = 1/24; nstep = tend/dt; % stepsize in time and number of time points
Alpha = dt*alpha;
Beta = dt*beta/N; Gamma = dt*gamma; Mu = dt*mu;
Rho = dt*rho;

maxit = 10; tol = 1e-6; % Newton's parameters
y = y0; yi(:, 1) = y;

for i = 1:nstep % nstep*dt days
    yinit = y; % initial guess for Newton's of the i-th step
    for k = 1:maxit
        % define vector f and its inf norm
        f = [(1+Mu+Rho)*y(1)+Beta*y(1)*y(3)-yi(1,i)-Mu*N;
        (1+Alpha+Mu)*y(2)-Beta*y(1)*y(3)-yi(2,i);
        -Alpha*y(2)+(1+Gamma+Mu)*y(3)-yi(3,i);
        -Gamma*y(3)+(1+Mu)*y(4)-yi(4,i);
        -Rho*y(1)+(1+Mu)*y(5)-yi(5,i)];
        fnorm =max(abs(f));
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
    yi(:, i+1) = y; % iteration results at each timestep
    nit(i) = k;
end

t = (0:nstep)'*dt; yn = y;
fprintf('day   S          E          I          R          V        tot\n');
fprintf('%5d %10.0f %9.0f %9.0f %9.0f %9.0f %10.0f\n', ...
         tend, yn, sum(yn));
fprintf('%5d %10.0f %9.0f %9.0f %9.0f %9.0f %10.0f\n', ...
         0, y0, sum(y0));
fprintf('max   %10.0f %9.0f %9.0f %9.0f %9.0f\n', max(yi'));

% find maximum infected and day
[M,I] = max(yi(3,:)); 
% average number of iterations
avg = sum(nit)/length(nit);
fprintf('max infected: %5d occuring day: %5d', M, I/24)
% do the plots

% plot of x_1^(i),...,x_5^(i) versus ih
ih = dt*[0:nstep];
plot(ih,yi(1,:),'-r',ih,yi(2,:),'g--',ih,yi(3,:),'b-.',...
    ih,yi(4,:),'black:',ih,yi(5,:),'.c');
xlabel('ih')
ylabel('number of people')
axis tight
legend('x_1^{(i)} S','x_2^{(i)} E','x_3^{(i)} I',...
    'x_4^{(i)} R','x_5^{(i)} V','Location','east')
title('Plot of x^{(i)} versus ih')

% plot of the number of iteration versus index of the timestep
plot(1:nstep,nit-1) % k-1 Newton iterations
axis([1 nstep 0.9 2.1])
xlabel('Index of the timestep')
ylabel('Number of Newton iteration')
title('Plot of number of iterations versus timestep index')

% additional plot in e
plot(ih,yi(2,:),'g--',ih,yi(3,:),'b-.')
legend('x_2^{(i)} E','x_3^{(i)} I')
xlabel('ih')
ylabel('number of people')
axis tight
title('x_2^{(i)} and x_3^{(i)} versus ih')
ylim([0 4*10^4])
