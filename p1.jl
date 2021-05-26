module p1

function ans1(n)
    sum(map(i -> ((i%3==0) || (i%5==0))*i, 1:n-1))
end
function ans2(n)
    sum = 0
    for i in 1:n-1
        sum += ((i%3==0) || (i%5==0))*i
    end
    return sum
end
function ans3(n)
    n -= 1
    Int(((3 + (3 * (n÷3))) * ((n÷3)/2)) +
    ((5 + (5 * (n÷5))) * ((n÷5)/2)) -
    ((15 + (15 * (n÷15))) * ((n÷15)/2)))
end
function all(below=100000000)
    @time a1 = p1.ans1(below)
    @time a2 = p1.ans2(below)
    @time a3 = p1.ans3(below)

    println("Method1: ", a1)
    println("Method2: ", a2)

    println("Method3: ", a3)
end
end
