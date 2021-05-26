module p46

function check(num, primes)
    for prime in primes
        if sqrt((num - prime)/2)%1==0.0
            return true
        end
    end
    return false
end

function ans()
    primes = [2,3,5,7]
    n = 9
    while true
        if findfirst(x->n%x==0, primes) == nothing
            push!(primes, n)
        elseif !check(n, primes)
            return n
        end
        n += 2
    end
end

end
