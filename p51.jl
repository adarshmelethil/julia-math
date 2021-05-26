module p51

function digit_count(num)
    l = 0
    while num > 0
        num ÷= 10
        l += 1
    end
    return l
end
function primes_till(ps, digits)
    if length(ps) < 1
        push!(ps, 2)
    end
    if length(ps) < 2
        push!(ps, 3)
    end

    n = last(ps)
    while digit_count(last(ps)) < digits+1
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
        end
    end
    return ps
end

function test(primes)
    tp = Int[56003, 56113, 56333, 56443, 56663, 56773, 56993]
    for i in 1:length(tp)-1
        # for j in i+1:length(tp)
        #     println(tp[j] - tp[i])
        # end
        println(tp[i]+110 == tp[i+1], " ", tp[i+1]-tp[i])
    end
end

function digits_to_num(ds)
    reduce((s,x)->s*10+x, ds, init=0)
end
function common_digits(num_digits)
    Set(map(num_digit->digits_to_num(map(x->x==num_digit, num_digits)), num_digits))
end

function only_digits(num_digits, changing_digits)
    changing_digits_matched = append!(
        zeros(Int, (length(num_digits) - length(changing_digits))),
        changing_digits)
    digits_to_num(
        map(val->val[2]==1 ? 0 : val[1],
            zip(num_digits, changing_digits_matched)))
end

function family_count(primes, family_count)
    # tp = Int[56003, 56113, 56333, 56443, 56663, 56773, 56993]
    answers = Tuple{Int, Int}[]
    for (pi, primei) in enumerate(primes)
        primei_digits = reverse(digits(primei))
        primei_cd = common_digits(primei_digits)
        counter = Dict{Int, Int}()
        for pj in pi+1:length(primes)
            primej = primes[pj]
            prime_diff = primej-primei
            prime_diff_digits = reverse(digits(prime_diff))
            prime_diff_digits_nodup = Set(prime_diff_digits)
            if prime_diff == 0 ||
                length(prime_diff_digits_nodup) > 2 ||
                !(0 in prime_diff_digits_nodup)
                continue
            end

            diff_digit = first(prime_diff_digits)
            base_diff_digits = map(x->x÷diff_digit, prime_diff_digits)
            base_diff = digits_to_num(base_diff_digits)
            if !(base_diff in primei_cd)
                continue
            end
            if only_digits(reverse(digits(primej)), base_diff_digits) !=
                only_digits(primei_digits, base_diff_digits)
                continue
            end

            # println(primei, ": ", primej, " ", prime_diff, " ", base_diff)
            if haskey(counter, base_diff)
                counter[base_diff] += 1
            else
                counter[base_diff] = 2
            end
        end

        for (d, c) in counter
            if c == family_count
                # println(primei)
                # push!(answers, (primei, d))
                return primei, d
            end
        end
    end
    return nothing
end

function ans(prime_family)
    primes = Int[]
    primes_till(primes, 1)
    digits_end = Int[length(primes)-1]

    ds = 2
    while true
        primes_till(primes, ds)
        push!(digits_end, length(primes)-1)

        cur_primes = primes[digits_end[ds-1]+1:digits_end[ds]]
        res = family_count(cur_primes, prime_family)
        if res != nothing
            return res
        end
        ds += 1
    end
end
end
