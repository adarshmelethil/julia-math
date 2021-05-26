module p26
using Printf

function ud(d)
    dvs = Int[]
    val = 10
    while true
        push!(dvs, val)

        if val < d
            val *= 10
        else
            val = (val % d) * 10
        end

        if val == 0
            return 0
        end
        idx = findfirst(x->x==val, dvs)
        if idx != nothing
            return length(dvs[idx:length(dvs)])
        end
    end
end

function ans()
    largest_d = 0
    largest_r = 0
    for i in 3:2:1000
        i_r = ud(i)
        if i_r > largest_r
            largest_d = i
            largest_r = i_r
        end
    end
    return largest_d
end
end
