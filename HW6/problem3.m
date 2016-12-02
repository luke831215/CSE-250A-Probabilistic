%% 6.3.c
f = @(x)log(cosh(x));
fD1 = @(x)(exp(x)-exp(-x))./(exp(x)+exp(-x));
fD2 = @(x)4./(exp(x)+exp(-x)).^2;
Q = @(x,y)(f(y)+fD1(y).*(x-y)+0.5*(x-y).^2);
x = -4:0.0001:4;
figure;
hold on;
plot(x, f(x));
plot(x, Q(x, -2));
plot(x, Q(x, 1));
legend('f(x)', 'Q(x,-2)', 'Q(x,1)');


%% 6.3.f
x = zeros(20,1);

% x_0 = -2
x(1) = -2;
for i = 2 : 20
    x(i) = x(i-1) - fD1(x(i-1));
end
figure;
subplot(1,2,1);
plot(x);
xlabel('n');
ylabel('x_n');

% x_0 = 1
x(1) = 1;
for i = 2 : 20
    x(i) = x(i-1) - fD1(x(i-1));
end
subplot(1,2,2);
plot(x);
axis([0 20 -0.5 1]);
xlabel('n');
ylabel('x_n');


%% 6.3.g
% x = 1;
x = 3;
for i = 1 : 3
    x = x - fD1(x)/fD2(x);
    fprintf('%f\n',x);
end

%% 6.3.h
g = @(x) 0.1 * sum(log(cosh(x+[1;1/2;1/3;1/4;1/5;1/6;1/7;1/8;1/9;1/10])));
x = -5 : 0.0001 : 5;
index = find(g(x) == min(g(x)));
x_min = x(index);
g_min = g(x_min);
figure;
plot(x,g(x));
legend('g(x)')

%% 6.3.k
gD1 = @(x) 0.1 * sum(tanh(x+[1;1/2;1/3;1/4;1/5;1/6;1/7;1/8;1/9;1/10]));
x = zeros(20,1);
for i = 2 : 20
    x(i) = x(i-1) - gD1(x(i-1));
end
figure;
plot(x);
xlabel('n');
ylabel('x_n');
