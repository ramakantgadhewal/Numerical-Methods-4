g = 9.81;
v = 6;
ni = [8 16 32 64];
%(i) 
% define containers
t = zeros(64);
cond_num = [0 0 0 0];
for n = ni
    
% construct the matrix A
m1 = linspace(50,100,n)';
c1 = 50 - 20*linspace(0,1,n)';
e=ones(n, 1);
A1=spdiags([-e, e], [-1, 0], n, n); 
A1(:, end) = -m1;

% construct vector b
b1 = c1*v-m1*g;

% solve the system of equations using backslash
t1 = A1\b1;

% condition number of A
kappa1 = condest(A1);

% print the output
fprintf('n: %3d max(t): %10.3e min(t): %10.3e acceleration: %10.3e condition number: %10.3e0\n',...
n, max(t1), min(t1(1:n-1)), t1(n), kappa1);

% store the tension value in t for each n
s(1:n,log2(n/8)+1) = t1;

%store the condition number in cond_num for each n
cond_num(log2(n/8)+1) = kappa1;
end

% plot the tension components v.s. normalized index
plot([1:ni(1)-1]/ni(1), s(1:ni(1)-1, 1), 'r-', ...
[1:ni(2)-1]/ni(2), s(1:ni(2)-1, 2), 'g--', ...
[1:ni(3)-1]/ni(3), s(1:ni(3)-1, 3), 'b-.', ...
[1:ni(4)-1]/ni(4), s(1:ni(4)-1, 4), 'k.');
xlabel('Normalized Index');
ylabel('Tension');
legend('n=8','n=16','n=32','n=64');

% plot in log-log scale of kappa v.s. n
loglog(ni,cond_num,'k.-'); 
xlabel('n');
ylabel('Condition Number'); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%