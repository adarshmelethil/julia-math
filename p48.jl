module p48

function ld_pow(b, n, ld)
    val = b
    for _ in 2:n
        val *= b
        if val > ld
            val %= ld
        end
    end
    return val
end

function ans_mem(bound, last_n)
    ld = 10^last_n
    total = 0
    for i in 1:bound
        total += ld_pow(i, i, ld)
    end
    total % ld
end
function ans_time(bound, last_n)
    reduce((t, x)->t+BigInt(x)^x, 1:bound) % 10^last_n
end

end
