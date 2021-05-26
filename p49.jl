module p49

digit_count(n) = floor(log(10,n))+1

function check_diff(primes)
    lp = last(primes)
    for pi in length(primes)-1:-1:2
        diff = lp - primes[pi]
        other_prime = primes[pi]-diff
        if other_prime in primes
            return other_prime, primes[pi], lp
        end
    end
    return nothing
end

function ans()
    four_digit_primes = ndigit_primes(4)
    perms = Dict{Array{Int}, Array{Int}}()

    found_one = false
    for prime in four_digit_primes
        d = sort(digits(prime))
        if haskey(perms, d)
            push!(perms[d], prime)
        else
            perms[d] = Int[prime]
        end

        if length(perms[d]) >= 3
            ans = check_diff(perms[d])
            if ans != nothing
                if found_one
                    return "$(ans[1])$(ans[2])$(ans[3])"
                end
                found_one = true
            end
        end
    end
end
function ndigit_primes(ds)
    primes = [2,3,5,7]

    n = 9
    first_ds_digit = -1
    while true
        if findfirst(x->n%x==0, primes) == nothing
            push!(primes, n)

            dc = digit_count(n)
            if first_ds_digit == -1 && dc == ds
                first_ds_digit = length(primes)
            end
            if dc == ds+1
                break
            end
        end

        n += 2
    end
    primes[first_ds_digit:length(primes)-1]
end

end
