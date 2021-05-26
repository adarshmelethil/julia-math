module p43

function dtn(d)
    reduce((s,x)->s*10+x, d, init=0)
end

function fits_property(ds)
    # check dup
    if last(ds) in ds[1:length(ds)-1]
        return false
    end

    if length(ds) >= 5 && (ds[3]+ds[4]+ds[5])%3 != 0
        return false
    end
    if length(ds) >= 7 && dtn(ds[5:7])%7 != 0
        return false
    end
    if length(ds) >= 8 && dtn(ds[6:8])%11 != 0
        return false
    end
    if length(ds) >= 9 && dtn(ds[7:9])%13 != 0
        return false
    end
    if length(ds) >= 10 && dtn(ds[8:10])%17 != 0
        return false
    end
    return true
end
function ans()
    d_vals = [Int[i for i in 0:9] for _ in 0:9]
    d_vals[1] = Int[i for i in 1:9]
    # 2, 3, 4 => 2
    d_vals[4] = Int[0,2,4,6,8]

    # 3, 4, 5 => 3
    # d[3] + d[4] + d[5]
    # count(2,5,8) - count(1,4,7)

    # 4, 5, 6 => 5
    d_vals[6] = Int[0,5]

    # 5, 6, 7 => 7
    # d[5]d[6] - d[7]*2
    # d[5]d[6] - d[7]*5
    # d[5]d[6] - d[7]*9
    # d[5]*2 + d[6]d[7]

    # 6, 7, 8 => 11
    # d[7] - d[6] - d[8]

    # 7, 8, 9 => 13
    # d[7]d[8] - d[9]*9
    # d[7]*4 - d[8]d[9]

    # 8, 9, 10 => 17
    # d[8]d[9] - d[10]*5
    # d[8]d[9]*5 + d[10]*9

    d_val_idx = 1
    d_val_idxs = Int[] # indexs used per digit form d_vals
    total = 0
    while true
        if d_val_idx > 10
            val = reduce((s,(i, j))->s*10+d_vals[i][j], enumerate(d_val_idxs), init=0)
            # println(val)
            total += val
            d_val_idx -= 1
        end

        if d_val_idx <= 0
            break
        end

        start_idx = 1
        if d_val_idx == length(d_val_idxs)
            start_idx = pop!(d_val_idxs) + 1
        end

        found = 0
        ds = Int[d_vals[i][j] for (i, j) in enumerate(d_val_idxs)]
        for i in start_idx:length(d_vals[d_val_idx])
            push!(ds, d_vals[d_val_idx][i])

            if fits_property(ds)
                found = i
                break
            end
            pop!(ds)
        end
        if found < 1
            d_val_idx -= 1
        else
            d_val_idx += 1
            push!(d_val_idxs, found)
        end
    end
    return total
end

end
