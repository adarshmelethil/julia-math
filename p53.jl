module p53

function combinatorics(n,r)
    factorial(big(n))/(factorial(big(r))*factorial(big(n-r)))
end

function ans(;bound=10^6)
    counter = 0
    for n in 1:100
        for r in 1:n
            if combinatorics(n, r) > bound
                counter += 1
            end
        end
    end
    counter
end

end
