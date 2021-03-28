q = 0.018350467697256206326; % the assumed exact value
N = 20;
for K = 3:9
    y_N_plus_K = 0.1; % set an appropriate value for y_{N+K}
    y = zeros(1,N+K); % so the first N-1 entries are 0
    y(N+K) = y_N_plus_K;
    i = N + K -1;
    while i >= 20 
        y(i) = (y(i+1) + exp(1)^(-1))/(i + 1);
        fprintf('N+K-1: %3d y_{N+K-1}: %20.16f\n',i, y(i));
        i = i - 1;
    end
    fprintf('K:%3d y_20:%20.16f q:%20.16f error:%10.6e \n',...
    K, y(20), q, q-y(20));
end
A = zeros(n);

A(:,end) = m;
    for i = 1:n-1
        A(i,i) = 1;
        A(i+1,i) = -1;
    end