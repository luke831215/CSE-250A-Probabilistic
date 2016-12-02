clear all

T = 180000;

Pi = load('initialStateDistribution.txt');
A = load('transitionMatrix.txt');
B = load('emissionMatrix.txt');
Ot = load('observations.txt');

% iteration
l = zeros(26,T);
phi = zeros(T,26);
l(:,1) = log(Pi)+log(B(:,Ot(1)+1));

for t = 2:T 
    [ltmp, phi(t,:)] = max(l(:,t-1)+log(A));
    l(:,t) = ltmp' + log(B(:,Ot(t)+1));
end

% backtracking
S = zeros(T,1);
[~,ST] = max(l(:,T));
S(T) = ST;

for t = T:-1:2
    S(t-1) = phi(t,S(t));
end

% translate
char = ['a','b','c','d','e','f','g','h','i','j','k','l','m',...
        'n','o','p','q','r','s','t','u','v','w','x','y','z'];
sentence = char(S(1));
for i = 2:T
    if(S(i) ~= S(i-1))
        sentence = [sentence, char(S(i))];
    end
end
disp(sentence);

% figure
figure;
plot(S);
xlabel('time');
ylabel('most likely sequence');


