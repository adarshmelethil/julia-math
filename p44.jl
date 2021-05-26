module p44

# 3/2n^2 - 1/2n - v = 0
function is_pentogonal(v)
    a, b, c = 3/2, -1/2, -v
    dd = sqrt( (b^2)-(4*a*c) )
    ans = (-b + dd)/(2*a)
    ans == floor(ans)
end
# n(3*n - 1)/2 = v
# (3a^2 - a + 3b^2 - b) / 2
function pentagonal(n)
    n*(3*n-1)/2
end

function ans()
    a = 2
    while true
        for b in a:-1:1
            diff = pentagonal(a) - pentagonal(b)
            added = pentagonal(a) + pentagonal(b)
            if is_pentogonal(diff) && is_pentogonal(added)
                return diff
            end
        end
        a += 1
    end
end

end
