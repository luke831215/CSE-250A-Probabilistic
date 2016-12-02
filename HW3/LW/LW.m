% calculate LW of P(Bi=1|Z=128) of N samples

function result = LW(N, i)

    % to generate N samples
    samples = Random(N);
    
    % calculate LW
    numerator = 0;
    denominator = 0;

    for row = 1:N
        sample = samples(row,:);
        numerator = numerator + Indicator(sample, i) * Probability(sample);
        denominator = denominator + Probability(sample);
    end

    result = numerator/denominator;
end