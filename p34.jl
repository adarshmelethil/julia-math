module p34
using Plots
using Memoize

# 145 is a curious number, as 1! + 4! + 5! = 1 + 24 + 120 = 145.

# Find the sum of all numbers which are equal to the sum of the factorial of their digits.

# Note: as 1! = 1 and 2! = 2 are not sums they are not included.

# factorial
@memoize function f(i)
    if i == 0 || i == 1
        return 1
    end
    return i * f(i-1)
end

function digit_sum(num)
    while num ÷ 10 != 0
        sum = 0

        i = num
        while i != 0
            sum += i % 10
            i ÷= 10
        end

        num = sum
    end
    return num
end

function min_for_digit(digit)
    if digit == 0
        return 0
    elseif digit == 1
        return 10
    elseif digit == 2
        return 20
    end
    i = f(digit+1)
    multiple = 0
    while true
        new_i = i ÷ 10
        if new_i == 0
            if digit < i
                multiple += 1
            end
            break
        end
        i = new_i
        multiple += 1
    end
    return digit*(10^multiple) + multiple
end

# digits_factorial_sum
function dfs(i)
    sum = 0
    while i > 0
        remainder = i % 10
        i ÷= 10
        fac = f(remainder)
        sum += fac
    end
    return sum
end
function dsum(i)
    sum = 0
    while i > 0
        remainder = i % 10
        i ÷= 10
        sum += remainder
    end
    return sum
end

function ans()
    x = 10
    inc = 1
    mult = false
    while true
        digit_fac_sum = dfs(x)
        diff = x - digit_fac_sum

        # if x > 40785
        if x > 150
            break
        end

        if diff < 0
            inc *= 10
            mult = true
        else
            inc = 1
            mult = false
        end

        println(
            x, " - ", digit_fac_sum,
            " = ", x-digit_fac_sum,
            "\tinc: ", inc,
            "\tdsum: ", digit_sum(x))
        x += inc
        x ÷= inc
        x *= inc
    end
end

function test()
    digits = 1:10
    factorials = [f(x) for x in digits]
    min_val_for_digit = [min_for_digit(x) for x in digits]

end
function solve()
    n = 9000000:9999999+1
    p = Plots.plot(n, n)

    # allval = [dfs(i) for i in n]
    # Plots.plot!(p, n, allval)

    sums = [dfs(i) for i in n]
    # print(sums)
    Plots.plot!(p, n, sums,  seriestype = :scatter)


    # nval = [(i, dfs(i)) for i in n]
    # sorted_nval = sort(nval, by=x->x[2])
    # new_x  = [x[1] for x in sorted_nval]
    # for v in new_x
    #     print(v," ")
    # end
    # println()
    # newval = [x[2] for x in sorted_nval]
    # Plots.plot!(p, n, new_x)


    # x = []
    # val = 5
    # for nn in n
    #     append!(x, val)
    #     val += 10
    # end
    # xy = [dfs(i) for i in x]

    # Plots.plot!(p, n, allval, seriestype = :scatter)
    # Plots.plot!(p, n, allval)
    # Plots.plot!(p, n, x)
    # Plots.plot!(p, n, xy)
end

end
