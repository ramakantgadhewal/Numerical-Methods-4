x=10.^(-20:20);
a = 1;
% default setup

f_ori = @(x) (a+x).^0.25 - a.^0.25;
df_ori = @(x) 0.25*(a + x).^(-0.75);
% the original expression and its derivative

f_proposed = @(x) x./(((a+x).^0.5 + a.^0.5)*((a+x).^0.25 + a.^0.25));
df_proposed = @(x) (((a+x).^0.5 + a.^0.5)*((a+x).^0.25 + a.^0.25)- ...
x*(0.75*(a+x).^(-0.25)+a^0.25*0.5*(a+x).^(-0.5)+a^0.5*0.25*(a+x).^(-0.75)))./...
(((a+x).^0.5 + a.^0.5)*((a+x).^0.25 + a.^0.25)).^2;
% the proposed expression and its derivative

condition_ori = @(x_val) abs(x_val .* df_ori(x_val) ./ f_ori(x_val));
condition_proposed = @(x_val) abs(x_val .* df_proposed(x_val)...
./ f_proposed(x_val));
% the condition numbers of two functions

rel_error = @(x) (f_proposed(x) - f_ori(x))./ f_proposed(x); 
% the relative error wrt. the proposed expression

for i=1:41
    fprintf('x:%9.2e f(x):%12.5e g(x):%12.5e kf:%12.5e kg: %12.5e error:%10.2e0 \n'...
    ,x(i),f_ori(x(i)),f_proposed(x(i)), condition_ori(x(i)),...
    condition_proposed(x(i)),rel_error(x(i)));
end
