module p24

# A permutation is an ordered arrangement of objects.
# For example, 3124 is one possible permutation of the digits
# 1, 2, 3 and 4.
# If all of the permutations are listed numerically or alphabetically,
# we call it lexicographic order. The lexicographic permutations of 0, 1 and 2 are:

# 012   021   102   120   201   210

# What is the millionth lexicographic permutation of the digits
# 0, 1, 2, 3, 4, 5, 6, 7, 8 and 9?
struct NoValueFoundException <: Exception end
function pick(nums, ans, val_position; first=false)
    position_index = 0
    for j in 0:nums-1
        if j in ans
            continue
        end
        if first
            return j
        end
        position_index += 1
        if position_index >= val_position
            return j
        end
    end
    throw(NoValueFoundException())
end

function ans(nums, nth)
    ans = []

    for i in 1:nums-1
        sub_perms = factorial(nums-i)
        set_position = Int(ceil(nth/sub_perms))
        nth -= (set_position-1) * sub_perms

        j = pick(nums, ans, set_position)

        push!(ans, j)
    end

    push!(ans, pick(nums, ans, 0, first=true))
    return reduce((t, x) -> t*10 + x, ans, init=0)
end

end
