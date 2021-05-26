module p50
using Primes

function consecutives(num, cumsums, min_length)
    bottom_idx = 1
    top_idx = bottom_idx + min_length - 1
    while true
        if top_idx > length(cumsums)
            return min_length
        end
       
        val = cumsums[top_idx] - cumsums[bottom_idx]
        if val < num
            if top_idx+1 >= length(cumsums)
                return min_length
            end
            top_idx += 1
        elseif val > num
            # return min_length
            bottom_idx += 1
            if top_idx - bottom_idx < min_length
                top_idx += 1
            end
        else
            return top_idx - bottom_idx
        end
    end
end

function primes_below(bound)
    primes = Int[2,3,5,7]
    num = 9
    while num < bound
        if findfirst(x->num%x==0, primes) == nothing
            push!(primes, num)
        end
        num += 2
    end
    return primes
end

function num_primes(lo, hi)
    5 + floor(Int,
              hi / (log(hi) - 1.12) -
              lo / (log(lo) - 1.12 * (lo > 7)))
end

function ans2(bound)
    primes = Int[2,3,5,7]
    cumsums = Int[0,2,5,10,17]
    last_cum = 17

    largest_cum = 1
    largest_num = 2
    num = 9
    while num < bound
        if findfirst(x->num%x==0, primes) == nothing
            last_cum += num
            push!(primes, num)
            push!(cumsums, last_cum)

            new_cum = consecutives(num, cumsums, largest_cum)
            if new_cum > largest_cum
                # println(num, " - ", new_cum)
                largest_cum = new_cum
                largest_num = num
            end
        end
        num += 2
    end

    largest_cum, largest_num
end

function ans(bound)
    cumsums = Int[0,2,5,10,17]

    last_cum = 17

    num = 9
    largest_consecutive = 0
    largest_prime = 0
    while num < bound
        if findfirst(x->num%x==0, primes) == nothing
            last_cum += num
            push!(primes, num)
            push!(cumsums, last_cum)

            # consec = consecutives(num, cumsums)
            # if consec != nothing && largest_consecutive < consec
            #     largest_consecutive = consec
            #     largest_prime = num
            # end
        end
        num += 2
    end
    # println(cumsums)
    # cumsums, primes
    return largest_prime, largest_consecutive
end

function ans3(bound)
    primes = Primes.primes(bound)
    cumsums = Int[0]
    largest_cum = 1
    largest_num = 2
    for prime in primes
        push!(cumsums, prime+last(cumsums))
        new_cum = consecutives(prime, cumsums, largest_cum)
        if new_cum > largest_cum
            # println(num, " - ", new_cum)
            largest_cum = new_cum
            largest_num = prime
        end
    end
    largest_cum, largest_num
end

end
