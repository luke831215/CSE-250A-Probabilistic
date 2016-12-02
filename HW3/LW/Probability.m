% probability P(Z|B1, B2, ..., Bn)
% sample is B1, B2, ..., Bn, 1*n

function P_Z = Probability(sample)
    Z = 128;
    noise = 0.2;
    
    % calculate f(B) of Bn...B1
    f_B = 0;
    for i = 1:length(sample)
        f_B = f_B + 2^(10-i) * sample(1, i);
    end

    % calculate P(Z|B1, B2, ..., Bn)
    P_Z = noise^(abs(Z - f_B)) * (1-noise) / (1+noise);
end