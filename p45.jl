module p45

function triangle(n)
    n*(n+1)/2
end
function pentagonal(n)
    n*(3n-1)/2
end
function hexagonal(n)
    n*(2n-1)
end
function ans(;tn=2,pn=2,hn=2)

    T = triangle(tn)
    P = pentagonal(pn)
    H = hexagonal(hn)
    while T != P || P != H
        while T < H
            tn += 1
            T = triangle(tn)
        end
        while P < T
            pn += 1
            P = pentagonal(pn)
        end
        while H < P
            hn += 1
            H = hexagonal(hn)
        end
    end
    T
end

end
