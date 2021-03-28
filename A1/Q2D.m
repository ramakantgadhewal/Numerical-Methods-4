% Compute and output y0, ..., y20 using recursion (A)

q = 0.018350467697256206326; % the assumed exact value
y = zeros(1,21); % create a container matrix
y(1) = 1 - exp(1)^(-1);
fprintf('n:%3d y_n:%20.16f \n', 0, y(1));
for i = 2:21
    y(i) = (i - 1) * y(i - 1) - exp(-1); % calculation step
    fprintf('n:%3d y_n:%20.16f \n', i-1, y(i));
end
fprintf('n:%3d y_n:%20.16f q:%20.16f error:%10.6e\n', 20, y(21), q, q-y(21));


        

