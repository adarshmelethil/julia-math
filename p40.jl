module p40

function ans()
    nths = map(x->10^x, 1:6)
    product = 1
    ni = 1
    covered_digits = 9
    cur_digit = 2
    while ni < length(nths)
        nth = nths[ni]
        if nth < 10
            product *= nth
            ni += 1
            covered_digits = 9
            continue
        end

        bottom = 10^(cur_digit-1)
        top = (10^(cur_digit))-1

        digit_len = top - (bottom-1)
        n_top = digit_len*cur_digit + covered_digits
        if nth > n_top
            cur_digit += 1
            covered_digits = n_top
            continue
        end

        nn = nth-covered_digits
        cur_num = bottom + ((nn-1) ÷ cur_digit)
        relative_digit = ((nn-1) % cur_digit)+1

        product *= reverse(digits(cur_num))[relative_digit]
        ni += 1
        # covered_digits = n_top
    end
    return product
end

function fractil(n)
    reduce((a, x)->append!(a,x), map(x->reverse(digits(x)), 1:n), init=[])
end
function nums(n)
    nn = fractil(1000000)
    return nn[n], nn[n-5:n+5]
end

end
