module p32
using Combinatorics

function digits_to_num(ds)
    reduce((s,x)->s*10+x, ds, init=0)
end
function ans()
    all_digits = Int[i for i in 1:9]
    ans_sum = []
    for xc in 1:9-2
    # for xc in 1:9
        for yc in xc:9-1-xc
        # for yc in 1:9
            if (xc-1 + yc-1)+1 < 9-(xc+yc)
                continue
            end

            x_perms = permutations(all_digits, xc)
            for x_perm in x_perms
                digits_without_x = Int[i for i in all_digits if !(i in x_perm)]
                y_perms = permutations(digits_without_x, yc)
                for y_perm in y_perms
                    digits_without = Int[i for i in all_digits if !(i in x_perm || i in y_perm)]

                    x = digits_to_num(x_perm)
                    y = digits_to_num(y_perm)
                    ans = x * y
                    if sort(digits(ans)) == digits_without
                        push!(ans_sum, ans)
                    end
                end
            end
        end
    end
    return reduce(+, Set(ans_sum))
end

end
