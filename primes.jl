module MyPrimes

function check_prime(primes, num)
    i = 1
    while primes[i] <= floor(Int, sqrt(num))
        if num % primes[i] == 0
            return false
        end
        i += 1
    end
    return true
end

function primes(hi)
    primes = Int[2]
    n = 3
    while n <= hi
        if check_prime(primes, n)
            push!(primes, n)
        end
        n += 2
    end
    primes
end

end
