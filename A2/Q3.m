% (a)

ni = [2:13];
c = zeros(1,13);
e = zeros(1,13);
r = zeros(1,13);
v = zeros(1,13); % some containers
for n = ni
    Hn = hilb(n);
    bn = zeros(1,n)';
    for i =[1:n]
        syms j
        bni = symsum(j/(i+j-1),j,1,n);
        bn(i) = bni;
    end
    xn_hat = Hn\bn; % where warnings happen
    xn = [1:n]';
    rn = bn - Hn*xn_hat;
    kappan = cond(Hn);
    rel_error = norm(xn-xn_hat)/norm(xn);
    norm_rn = norm(rn);
    norm_bn = norm(bn);
    c(n) = kappan;
    e(n) = rel_error;
    r(n) = norm_rn;
    v(n) = norm_bn;
    fprintf('n: %2d condition number: %9.2e relative error: %9.2e norm of residual: %9.2e norm of b_n: %9.2e\n', ...
        n, kappan, rel_error, norm_rn, norm_bn);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%(b)
c = c([2:end]);
e = e([2:end]);
r = r([2:end]);
v = v([2:end]);
semilogy(ni,c,'-d',ni,e,'--v',ni,c.*r./v,':o')
hold on
grid on
xlabel('n')
ylabel('log scale')
legend('condition number', 'relative error','cr/v','Location','southeast');