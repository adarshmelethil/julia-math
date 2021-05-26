module p25

function digit_count(n)
    d = 0
    while n > 0
        d += 1
        n ÷= 10
    end
    return d
end

function fib(n)
    i, a, b = 1, 0, 1
    while digit_count(b) < n
        c = b
        b = a + b
        a = c
        i += 1

        println(i, ": ", b, digit_count(b))
    end
end

function ans(n)
    i = 1
    a = 0
    b = 1
    digits = 1

    while digits < n
        c = b
        b = a + b
        a = c
        i += 1

        if b > 9
            digits += 1
            a /= 10
            b /= 10
        end
    end
    return i
end

end
