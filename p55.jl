module p55

function palindrome(n)
    d = digits(n)
    i,j=1,length(d)
    while i < j
        if d[i] != d[j]
            return false
        end
        i += 1
        j -= 1
    end
    return true
end

function lychrel(i)
    for a in 1:49
        ii = reduce((s,x)->s*10+x, digits(i), init=0)
        i = ii + big(i)
        if palindrome(i)
            return false
        end
    end
    return true
end

function ans(;bound=10^4)
    count(lychrel, 1:bound-1)
end

end
