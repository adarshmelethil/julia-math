module p21

function d(num)
    n = 2
    t = 1
    while n <= sqrt(num)
        if num % n == 0
            t += n
            nn = (num ÷ n)
            if n != nn
                t += nn
            end

        end
        n += 1
    end
    return t
end

function ans1(bound)
    s = 0
    for i in 1:bound-1
        ds = d(i)
        if ds == i
            continue
        end
        if d(ds) == i
            s += i
        end
    end
    return s
end
function ans2(bound)
    s = 0
    i = 1
    while i < bound
        ds = d(i)
        if ds != i && d(ds) == i
            s += i
            if ds >= bound
                return s
            end
            s += ds
            i = ds
        end
        i += 1
    end
    return s
end

end
