module p30
using Plots

# sum_digits
function sd(num, p)
    sum([i^p for i in digits(num)])
end
function sd2(n, p)
    sum([((n%(10^(i+1))-n%(10^i))/10^i)^p for i in 0:floor(log(10, n))+1])
end
function expl(n, p)
    x = 0:n
    y = Int[sd(i, p) for i in x]

    p = plot(x, y, legend=:topleft, xticks=0:n÷10:n)
    plot!(p, x, x)
end
function nexttop(num)
    if num < 10
        return 9
    end
    num_digit = floor(log(10, num))
    new_num = num ÷ 10^num_digit
    new_num = ((new_num+1)*10^num_digit)-1
    Int(new_num)
end
function ans(p)
    s = 0
    cd = floor(log(10, 2^p)) + 1
    num = Int(10^(cd-1))
    while true
        numtop = nexttop(num)
        for n in num:numtop
            digit_sum = sd(n, p)
            if digit_sum == n
                s += n
            end
        end
        if sd(numtop, p) < numtop
            break
        end

        # println(numtop)
        num = numtop+1
    end
    return s
end

end
