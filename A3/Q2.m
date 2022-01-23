%(a) 
%x = linspace(0, pi, 1000);
%y1 = sin(x);
%y2 = 1./x;
%plot(x,y1,x,y2)
%ylim([0 pi])
%legend('y1=sin(x)','y2=1/x')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%(e)
x1 = [-1,1];
y1 = [exp(1),1/exp(1)];
x2 = [-1,0,1];
y2 = [exp(1),1,1/exp(1)];
p1 = polyfit(x1,y1,1);
p2 = polyfit(x2,y2,2);
fprintf('p_1(x) interpolation\n');
fprintf('%3f %3f \n',polyval(p1,x1));
fprintf('p_2(x) interpolation\n');
fprintf('%3f %3f %3f \n',polyval(p2,x2));

x = linspace(-1,1,100);
u1 = 1-x;
u2 = 1-x + 0.5*x.^2;
v1 = polyval(p1,x);
v2 = polyval(p2,x);
vf= exp(-x);
fprintf('max absolute values of errors\n')
fprintf('vf-v1:%3f vf-v2: %3f vf-u1: %3f vf-u2: %3f\n',max(abs(vf-v1)),max(abs(vf-v2)),max(abs(vf-u1)),max(abs(vf-u2)))

% the first plot
plot(x,v1,'-b',x,v2,'--r',x,u1,':black',x,u2,'-. m',x,vf,'c-')
legend('v_1','v_2','u_1','u_2','v_f')
xlabel('[-1,1]')
ylabel('polynomial values')
title('Plot of 5 polynomial values versus equidistant points in[-1,1]')

% the second plot
plot(x,vf-v1,'-b',x,vf-v2,'--r',x,vf-u1,':k',x,vf-u2,'-.m')
legend('v_f-v_1','v_f-v_2','v_f-u_1','v_f-u_2')
xlabel('[-1,1]')
ylabel('Difference from the true values')
title('Plot of errors versus equidistant points in[-1,1]')

