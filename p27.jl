module p27

function another_prime(ps)
    if length(ps) == 0
        push!(ps, 2)
        return ps
    elseif length(ps) == 1
        push!(ps, 3)
        return ps
    end

    n = last(ps)
    while true
        n += 2
        isPrime = true
        for p in ps
            if n % p == 0
                isPrime = false
                break
            end
        end
        if isPrime
            push!(ps, n)
            return ps
        end
    end
end

function num_primes(a,b, primes)
    n = 0
    while true
        p = n^2 + a*n + b
        while last(primes) < p
            another_prime(primes)
        end
        if !(p in primes)
            return n
        end
        n += 1
    end
end

function brute()
    primes = another_prime([])
    lp_count = 0
    lp_a = 0
    lp_b = 0
    for a in -1000:1000
        for b in 1:1000
            count = num_primes(a, b, primes)
            if count > lp_count
                lp_count = count
                lp_a = a
                lp_b = b
            end
        end
    end
    return lp_a, lp_b, lp_count
end

# n^2 + an + b
function ans()
    primes = another_prime([])
    another_prime(primes)
    another_prime(primes)

    lp_count = 0
    lp_coeff = 0
    b = 2
    while primes[b] < 1000
        while length(primes) <= b+1
            another_prime(primes)
        end
        a1 = (primes[b-1] - primes[b]) - 1
        a2 = (primes[b+1] - primes[b]) - 1

        if abs(a1) < 1000
            a_c = num_primes(a1, b, primes)
            if a_c > lp_count
                lp_count = a_c
                lp_coeff = a1*b
            end
        end
        if a2 < 1000
            a_c = num_primes(a2, b, primes)
            if a_c > lp_count
                lp_count = a_c
                lp_coeff = a2*b
            end
        end
        b += 1
    end
    return lp_coeff, lp_count
end

end
