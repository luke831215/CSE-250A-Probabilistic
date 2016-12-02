clear all

[x_00] = textread('nasdaq00.txt', '%f');

% A 4*4
A = zeros(4,4);
for t = 5: length(x_00)
    x_t = [x_00(t-1,1); x_00(t-2,1); x_00(t-3,1); x_00(t-4,1)];
    A = A + x_t * (x_t)';
end

% b 4*1
b = zeros(4,1);
for t = 5: length(x_00)
    for i = 1:4
        b(i,1) = b(i,1) + x_00(t,1) * x_00(t-i,1);
    end
end

% Aw = b
w = A^(-1) * b;

% SWE
% 2000
SWE_00 = 0;
for t = 5:length(x_00)
    x_t = [x_00(t-1,1); x_00(t-2,1); x_00(t-3,1); x_00(t-4,1)];
    SWE_00 = SWE_00 + (x_00(t,1) - w'*x_t)^2;
end
SWE_00 = SWE_00/(length(x_00)-4);

% 2001
[x_01] = textread('nasdaq01.txt', '%f');
SWE_01 = 0;
for t = 5:length(x_01)
    x_t = [x_01(t-1,1); x_01(t-2,1); x_01(t-3,1); x_01(t-4,1)];
    SWE_01 = SWE_01 + (x_01(t,1) - w'*x_t)^2;
end
SWE_01 = SWE_01/(length(x_01)-4);
