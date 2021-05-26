module p47

function prime_factors(num, primes)
    count = 0
    for prime in primes
        if num % prime == 0
            count += 1
            while num % prime == 0
                num /= prime
            end
        end
        if num == 1
            break
        end
    end
    return count
end


function ans(val)
    primes = Int[2,3,5,7]
    n = 9
    counter = 0
    while true
        pfs = prime_factors(n, primes)
        if pfs == 0
            push!(primes, n)
            counter = 0
        elseif pfs == val
            counter += 1
        else
            counter = 0
        end

        if counter == val
            return n-(val-1)
        end
        n += 1
    end
end

end
