module p52

function check(n)
    nd = sort(digits(n))
    for i in 2:6
        if nd != sort(digits(n*i))
            return false
        end
    end
    return true
end

function ans()
    n = 2
    while !check(n)
        n += 1
    end
    n
end

end
