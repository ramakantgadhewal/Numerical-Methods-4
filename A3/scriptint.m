a = -1; b = 2;
xe = linspace(a, b, 1000);
ye = exp(-xe);

disp(['interval (' num2str(a) ',' num2str(b), ')'])
disp('  n    err poly   err lin_spl')
for nn = 1:6
    n = 2^nn;
    xi = linspace(a, b, n+1);
    yi = exp(-xi);
    py = polyfit(xi,yi,n);
    yp = polyval(py,xe); % polynomial interpolant at (xi, yi), evaluated at xe
    yl = interp1(xi,yi,xe,'linear'); % linear spline interpolant at (xi, yi), evaluated at xe
    ep = max(abs(yp-ye)); % infinity error norm of polynomial interpolant
    el = max(abs(yl-ye)); % infinity error norm of linear spline interpolant
    fprintf('%3d %12.3e %12.3e\n', n, ep, el);
end

fprintf('\n')
disp(['interval (' num2str(a) ',' num2str(b), ')'])
disp('    n   err lin_spl err cub_spl')
for nn = 4:14
    n = 2^nn;
    xi = linspace(a, b, n+1);
    yi = exp(-xi);
    yl = interp1(xi,yi,xe,'linear'); % linear spline interpolant at (xi, yi), evaluated at xe
    yc = spline(xi,yi,xe); % cubic spline interpolant at (xi, yi), evaluated at xe
    el(nn) = max(abs(yl-ye)); % infinity error norm of linear spline interpolant
    ec(nn) = max(abs(yc-ye)); % infinity error norm of cubic spline interpolant
    fprintf('%5d %12.3e %12.3e ', n, el(nn), ec(nn));
    if (nn > 4)
        fprintf('%6.1f %6.1f\n', log(el(nn-1)/el(nn))/log(2), ...
                                 log(ec(nn-1)/ec(nn))/log(2));
    else fprintf('\n'); end
end