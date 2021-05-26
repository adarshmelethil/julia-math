module p38

function ans()
    largest_val = 0
    val = 9
    while true
        ds = reverse(digits(val))
        if length(ds) > 9
            break
        end
        for i in 2:9
            append!(ds, reverse(digits(val*i)))
            if length(ds) > 9 && i == 2
                return largest_val
            elseif 0 in ds || length(ds) > 9 || length(Set(ds)) != length(ds)
                break
            elseif length(ds) < 9
                continue
            else
                val_digits = reduce((s,x)->s*10+x, ds, init=0)
                if val_digits > largest_val
                    largest_val = val_digits
                end
                break
            end
        end
        val += 1
    end
    return largest_val
end

end
