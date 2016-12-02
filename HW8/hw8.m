clear all

%% load
S = 81;
A = 4;
gamma = 0.9925;
All = zeros(A,S,S);

a1 = load('prob_a1.txt');
for k = 1:size(a1,1)
    All(1,a1(k,1),a1(k,2)) = a1(k,3);
end
a2 = load('prob_a2.txt');
for k = 1:size(a2,1)
    All(2,a2(k,1),a2(k,2)) = a2(k,3);
end
a3 = load('prob_a3.txt');
for k = 1:size(a3,1)
    All(3,a3(k,1),a3(k,2)) = a3(k,3);
end
a4 = load('prob_a4.txt');
for k = 1:size(a4,1)
    All(4,a4(k,1),a4(k,2)) = a4(k,3);
end

rewards = load('rewards.txt');

%% (a) value iteration
P1 = zeros(A,S);
V_old = zeros(S,1);
V_star = V_old;
for k = 1:S
    P1(:,:) = All(:,k,:);
    V_star(k) = rewards(k) + gamma * max(P1*V_old);   
end
% iterate until converge
while sum(V_star ~= V_old) > 0
    V_old = V_star;
    for k = 1:S
        P1(:,:) = All(:,k,:);
        V_star(k) = rewards(k) + gamma * max(P1*V_old);   
    end
end

% print out non-zero
res = zeros(1,2);
for k = 1:S
    if V_star(k) ~= 0
       res = [res;k,V_star(k)];
    end
end
disp(res(2:size(res,1),:));

%% (b) policy pi
Pi_star = zeros(S,1);
for k = 1:S
    P1(:,:) = All(:,k,:);
    [~,Pi_star(k)] = max(P1*V_star);   
end

%% (c) policy iteration

% EAST
Pi_1 = ones(S,1)*3;
for k = 1 : S
    P1(k,:) = All(Pi_1(k),k,:);
end
Pi_old = zeros(S,1);
iter1 = 0;
while sum(Pi_1 ~= Pi_old) > 0
    iter1 = iter1 + 1;
    Pi_old = Pi_1;
    V = (eye(S)-gamma*P1)^(-1)*rewards;
    for k = 1 : S
        Prob(:,:) = All(:,k,:);
        [~, Pi_1(k)] = max(Prob*V);
        P1(k,:) = All(Pi_1(k),k,:);
    end
end

% SOUTH
Pi_2 = ones(S,1)*4;
for k = 1 : S
    P2(k,:) = All(Pi_2(k),k,:);
end
Pi_old = zeros(S,1);
iter2 = 0;
while sum(Pi_2 ~= Pi_old) > 0
    iter2 = iter2 + 1;
    Pi_old = Pi_2;
    V = (eye(S)-gamma*P2)^(-1)*rewards;
    for k = 1 : S
        Prob(:,:) = All(:,k,:);
        [~, Pi_2(k)] = max(Prob*V);
        P2(k,:) = All(Pi_2(k),k,:);
    end
end





