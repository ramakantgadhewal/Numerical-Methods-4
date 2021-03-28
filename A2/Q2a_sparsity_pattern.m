% sparsity patterns of A, P, L, U when n=16
m16 = linspace(50,100,16)';
c16 = 50 - 20*linspace(0,1,16)';
e16=ones(16, 1);
A16=spdiags([-e, e], [-1, 0], 16, 16); 
A16(:, end) = -m16;
[L16,U16,P16] = lu(A16);

subplot(2,2,1)
spy(A16)
title('A');
subplot(2,2,2)
spy(P16)
title('P');
subplot(2,2,3)
spy(L16)
title('L');
subplot(2,2,4)
spy(U16)
title('U');