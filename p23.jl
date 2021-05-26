module p23
using DataStructures

function abundant(num)
    s = 1
    i = 2
    while i <= sqrt(num)
        if num % i == 0
            s += i
            ii = num ÷ i
            if i != ii
                s += ii
            end
        end
        i += 1
    end
    return s > num
end

function is_sum_of(arr, val)
    l = length(arr)
    for i in 1:l-1
        for j in i:l
            if arr[i] + arr[j] == val
                return true
            end
        end
    end
    return false
end

function ans(;upper_bound=28123)
    s = 0
    abundants = Int[]
    for i in 1:upper_bound
        if abundant(i)
            push!(abundants, i)
        end

        if !is_sum_of(abundants, i)
            s += i
        end
    end
    return s
end

function test()
    ub = 28123
    abundants = Int[]
    for i in 1:ub
        if abundant(i)
            if i % 2 == 1
                println(i)
            end
        end
    end
end

function sumup(a, b)
    n = b-a+1
    return Int((b+a)*(n/2))
end
function ans2(;ub=28123)
    abundants = Int[i for i in 12:ub if abundant(i)]
    al = length(abundants)

    sums = Int[]
    for a1 in 1:al-1
        for a2 in a1:al
            ss = abundants[a1]+abundants[a2]
            if ss <= ub
                push!(sums, ss)
            end
        end
    end

    sums = SortedSet(sums)
    return reduce((s, c)-> [s[1]+ sumup(s[2]+1, c-1), c], sums, init=[0,0])[1]
end

end
