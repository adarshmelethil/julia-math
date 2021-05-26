module p29

function t(upper)
    for a in 1:upper
        if a == 1
            print("\t")
        else
            print(a, "\t")
        end
    end
    println()
    for a in 2:upper
        for b in 1:upper
            if a == 1
                print(a, "\t")
            else
                print(a^b, "\t")
            end
        end
        println()
    end
end
function b(upper)
    nums = Int[]

    for a in 1:upper
        if a == 1
            print("\t")
        else
            print(a, "\t")
        end
    end
    println()
    for a in 2:upper
        for b in 1:upper
            if b == 1
                print(a, "\t")
                continue
            else
                n = a^b
                dd = ""
                if n in nums
                    dd = "@"
                else
                    push!(nums, n)
                end
                print(n, dd, "\t")
            end
        end
        println()
    end
end
function brute(upper)
    nums = BigInt[]
    for a in 2:upper
        for b in 2:upper
            push!(nums, BigInt(a)^b)
        end
    end
    return length(Set(nums))
end
function ans(upper)
    s = (upper - 1)^2
    for a in 2:upper
        for b in 2:upper
            n = a^b # another base that is b amount of 'a'
            if n > upper
                break
            else
                # (upper ÷ a)
                dups = ((upper ÷ b) - 1)
                println(a, "x", b, "=", n, " ", dups)
                s -= dups
            end
        end
    end
    return s
end
end
