clear all;
% Gradient Ascent

%% ---- training -----

% label yt = 0 for 3 
% label yt = 1 for 5
x3 = load('train3.txt');
x5 = load('train5.txt');
y3 = zeros(size(x3, 1), 1);
y5 = ones(size(x5, 1), 1);
T = [x3;x5];
Y = [y3;y5];
I = ones(size(Y));
 
% Config of Learning
iter = 50000;
rate = 0.02/100;

% initialize weight
W = rand(64, 1); 
for i = 1:iter
    Grad = T'*(Y - sigmoid(T*W));
    W = W + rate*Grad;
    err(i) = sum(Y ~= (sigmoid(T*W)>=0.5))/length(Y);
    L(i) = Y'*log(sigmoid(T*W)) - (I-Y)'*log(sigmoid(-T*W));
end
figure(1);
plot(L(20:end)), xlabel('Iterations'), ylabel('Log-likelihood');
figure(2);
plot(err), xlabel('Iterations'), ylabel('Error rate');

%% ---- testing -----

t3 = load('test3.txt');
t5 = load('test5.txt');
y3 = zeros(size(t3, 1), 1);
y5 = ones(size(t5, 1), 1);
T = [t3;t5];
Y = [y3;y5];
errorAll = sum(Y ~= (sigmoid(T*W)>=0.5))/length(Y);
errorOn3 = sum(y3 ~= (sigmoid(t3*W)>=0.5))/length(y3);
errorOn5 = sum(y5 ~= (sigmoid(t5*W)>=0.5))/length(y5);

%% ---- sigmoid function ----
% function: sigmoid for a matrix at each [i][j]
function res = sigmoid(X)

    I = ones(size(X));
    E = ones(size(X))*exp(1);
    res = I./(I+E.^(-X));
    
end
