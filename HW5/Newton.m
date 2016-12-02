function [L,w] = Newton(w)

    % label 3 Y3 = 1;
    % label 5 Y5 = 0;
    x3 = textread('train3.txt', '%d');
    y3 = 1;
    x5 = textread('train5.txt', '%d');
    y5 = 0;
    
    % gradient
    grad = zeros(64,1);
    for i = 1 : 64 : length(x3)
        x_t = x3(i : i+63, 1);
        grad = grad + (y3 - 1/[1+exp(w'*x_t)]) * x_t;
    end
    for i = 1 : 64 : length(x5)
        x_t = x5(i : i+63, 1);
        grad = grad + (y5 - 1/[1+exp(w'*x_t)]) * x_t;
    end

    % Hessian
    hess = zeros(64,64);
    for i = 1 : 64 : length(x3)
        x_t = x3(i : i+63, 1);
        hess = hess - (1/[1+exp(w'*x_t)] * 1/[1+exp(-w'*x_t)]) * x_t * x_t';
    end
    for i = 1 : 64 : length(x5)
        x_t = x5(i : i+63, 1);
        hess = hess - (1/[1+exp(w'*x_t)] * 1/[1+exp(-w'*x_t)]) * x_t * x_t';
    end

    % using Newton's 
    w = w - hess^(-1)* grad; 
    
    % log-likelihood
    L = 0;
    for i = 1 : 64 : length(x3)
        x_t = x3(i : i+63, 1);
        L = L + log(1/[1+exp(w'*x_t)]);
    end
    for i = 1 : 64 : length(x5)
        x_t = x5(i : i+63, 1);
        L = L + log(1/[1+exp(-w'*x_t)]);
    end
end