% to generate N random samples

function samples = Random(N)
    samples = zeros(round(N), 10);
    for row = 1:N
        temp = int8(rand(1,10));
        samples(row, :) = temp;
    end
end