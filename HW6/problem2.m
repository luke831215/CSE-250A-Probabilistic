xt = load('spectX.txt');
yt = load('spectY.txt');

% config of EM
[T, n] = size(xt);
iter = 257;
pi = ones(1,n)/n;
Ti = sum(xt);
res = zeros(iter, 2);

for i = 1 : iter
    % update pi
    prob(1:T,1) = 1-prod((1-pi)'.^(xt(1:T,:)'));
    Pzx = xt .* yt .* pi ./ prob;
    pi = sum(Pzx)./Ti;
    % mistake
    M = sum(abs(round(prob)-yt));
    % log-likelihood
    L = sum(log(yt.*prob + (1-yt).*(1-prob)))/T;
    res(i,:) = [M, L];
end
