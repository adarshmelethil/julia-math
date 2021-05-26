module p33

function combos(n, d)
    counts = []
    for i in 1:9
        val = n/d
        n1 = i*10+n
        n2 = n*10+i
        d1 = i*10+d
        d2 = d*10+i

        if i > 0 && n1/d1 == val
            push!(counts, (n, d,))
        end
        if i > 0 && n1/d2 == val
            push!(counts, (n, d,))
        end
        if i > 0 && n2/d1 == val
            push!(counts, (n, d,))
        end
        if n2/d2 == val
            push!(counts, (n, d,))
        end
    end
    return counts
end

function prime_factors(num)
    primes = Int[2,3,5,7]
    pfs = Int[]
    for prime in primes
        while num % prime == 0
            push!(pfs, prime)
            num ÷= prime
        end
    end
    return pfs
end

function fraction_append(n, checker, putter)
    if n in checker
        filter!(x->x!=n, checker)
    else
        push!(putter, n)
    end
end

function ans()
    ns = Int[]
    ds = Int[]
    for d in 2:9
        for n in 1:d-1
            for (nn, dd) in combos(n, d)
                for np in prime_factors(nn)
                    fraction_append(np, ds, ns)
                end
                for dp in prime_factors(dd)
                    fraction_append(dp, ns, ds)
                end
            end
        end
    end
    reduce(*, ds)
end

end
