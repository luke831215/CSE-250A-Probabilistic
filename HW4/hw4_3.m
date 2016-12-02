clear all

[words] = textread('vocab.txt', '%s');
[counts] = textread('unigram.txt', '%d');
[w1,w2,count] = textread('bigram.txt', '%d %d %d');

%% ------ (a) ------

P_unigram = zeros(size(counts));
total = sum(counts);
for i = 1 : length(counts)
    P_unigram(i) = counts(i)/total;
end
% sorted by frequency in acsending order
i = 1;
fprintf('----- (a) -----\n');
fprintf('tokens:\t \t unigram probability: \n');
while(i < 500)
    if(words{i}(1) == 'A')
        fprintf('%s \t \t %f \n', words{i}, P_unigram(i));
    end
    i = i+1;
end

%% ------ (b) ------

P_bigram = zeros(size(w1));
total = sum(count);

for i = 1 : length(w1)
    P_bigram(i) = count(i)/counts(w1(i));
end
Bigram = [w1 w2 count P_bigram];
% extract tuples where w1 == THE
tmp_the = [];
for i = 1 : length(w1)
    if(Bigram(i,1) == 4)
        tmp_the = [tmp_the; Bigram(i,:)];
    end
end
% sorting
[sorted_p, index] = sort(tmp_the(:,4),'descend');
fprintf('----- (b) -----\n');
fprintf('Most likely: \t \t bigram probability:\n');
for i = 1 : 5
    w2_index = tmp_the(index(i), 2);
    fprintf('%s \t \t \t %f\n', words{w2_index}, tmp_the(index(i),4));
end

%% ------ (c) ------

sentence = {'<s>', 'LAST', 'WEEK',  'THE', 'STOCK', ...
            'MARKET', 'FELL', 'BY', 'ONE', 'HUNDRED', 'POINTS'};
indexes = zeros(size(sentence));
P_u = zeros(size(sentence));
P_b = zeros(size(sentence));
indexes(1) = 2;
for i = 2 : length(sentence)
    for j = 1 : length(words)
        if(strcmpi(words{j}, sentence(i)))
            P_u(i) = P_unigram(j);
            indexes(i) = j;
        end
    end
end

for i = 2 : length(sentence)
    for j = 1 : length(w1)
        if(w1(j) == indexes(i-1) && w2(j) == indexes(i))
            P_b(i) = P_bigram(j);
        end
    end
end
L_u = 0;
L_b = 0;
for i = 2 : length(sentence)
     L_u = L_u + log(P_u(i));
     L_b = L_b + log(P_b(i));
end
fprintf('----- (c) -----\n');
fprintf('L_u: %f \nL_b: %f\n', L_u,L_b);

%% ------ (d) ------

sentence_2 = {'<s>', 'THE', 'NINETEEN',  'OFFICIALS', ...
              'SOLD',  'FIRE', 'INSURANCE'};
indexes_2 = zeros(size(sentence_2));
P_u_2 = zeros(size(sentence_2));
P_b_2 = zeros(size(sentence_2));
indexes_2(1) = 2;
for i = 2 : length(sentence_2)
    for j = 1 : length(words)
        if(strcmpi(words{j}, sentence_2(i)))
            P_u_2(i) = P_unigram(j);
            indexes_2(i) = j;
        end
    end
end
fprintf('----- (d) -----\n');
for i = 2 : length(sentence_2)
    for j = 1 : length(w1)
        if(w1(j) == indexes_2(i-1) && w2(j) == indexes_2(i))
            P_b_2(i) = P_bigram(j);
            
        end
    end
end
fprintf('two pairs:\n');
for i = 2 : length(P_b_2)
    if(P_b_2(i) == 0)
       fprintf('w1 : %s \t w2 : %s\n', words{indexes_2(i-1)},words{indexes_2(i)});
    end
end
L_u_2 = 0;

for i = 2 : length(sentence_2)
     L_u_2 = L_u_2 + log(P_u_2(i));
end

fprintf('L_u: %f \n', L_u_2);

%% ------ (e) ------

lamda = 0 : 0.0001 :1;
L_m = zeros(size(lamda));
for i = 1 : length(lamda)
    P_m = (1-lamda(i))*P_u_2 + lamda(i)*P_b_2;
    for j = 2 : length(sentence_2)
     L_m(i) = L_m(i) + log(P_m(j));
    end
end
plot(L_m);
xlabel('lamda * 10^{-4}');
ylabel('Log-likelihood L_m');
hold on
[ymax indmax]=max(L_m);
xmax=lamda(indmax);
fprintf('----- (e) -----\n');
fprintf('max lamda=%4.2f, L_m =%4.2f\n',xmax,ymax);












