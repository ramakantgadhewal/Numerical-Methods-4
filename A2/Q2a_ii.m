%(ii)
g = 9.81;
v = 6;
t = zeros(64);
ni = [8 16 32 64];
for n = ni
    
% construct the matrix A
m2 = sort(50 + 50*rand(n, 1), 'ascend');
c2=sort(30 + 20*rand(n, 1), 'descend');
e=ones(n, 1);
A2=spdiags([-e, e], [-1, 0], n, n); 
A2(:, end) = -m2;

% construct vector b
b2 = c2*v-m2*g;

% solve the system of equations using backslash
t2 = A2\b2;

% condition number of A
kappa2 = condest(A2);

% print the output
fprintf('n: %3d max(t): %10.3e min(t): %10.3e acceleration: %10.3e condition number: %10.3e0\n',...
n, max(t2), min(t2(n-1)), t2(n), kappa2);

% store in s
t(1:n,log2(n/8)+1) = t2;
end

% plot the tension components v.s. normalized index
plot([1:ni(1)-1]/ni(1), t(1:ni(1)-1, 1), 'r-', ...
[1:ni(2)-1]/ni(2), t(1:ni(2)-1, 2), 'g--', ...
[1:ni(3)-1]/ni(3), t(1:ni(3)-1, 3), 'b-.', ...
[1:ni(4)-1]/ni(4), t(1:ni(4)-1, 4), 'k.');
xlabel('Normalized Index');
ylabel('Tension');
legend('n=8','n=16','n=32','n=64');