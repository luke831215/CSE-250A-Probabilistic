% Indicator I(q, q_i)

function I = Indicator(sample, i)
    if sample(1, 10-i+1) == 1
        I = 1;
    else
        I = 0;
    end
end