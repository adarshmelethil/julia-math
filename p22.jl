module p22


function sorted_insert(arr, val)
    if length(arr) == 0
        return insert!(arr, 1, val)
    end
    for (i, v) in enumerate(arr)
        if v >= val
            return insert!(arr, i, val)
        end
    end
    return push!(arr, val)
end

function worth(name)
    t = 0
    for n in name
        t += (Int(n) - 64)
    end
    return t
end
function worth2(name)
    reduce((s, n)-> s+(Int(n)-64), name, init=0)
end
function add_up(arr)
    sum = 0
    for (i, v) in enumerate(arr)
        sum += i * worth(v)
    end
    return sum
end

function write_to_file(arr)
    outfile = "sorted_names.txt"
    open(outfile, "w") do f
        for i in arr
            println(f, i)
        end
    end
end

function ans()
    names_string = open(f->read(f, String), "p022_names.txt")

    sorted_list = []
    name = ""
    for n in names_string
        if n == '"'
            continue
        elseif n == ','
            sorted_insert(sorted_list, name)
            name = ""
            continue
        end
        name *= n
    end
    if name != ""
        sorted_insert(sorted_list, name)
    end
    return (add_up(sorted_list))
end

function ans2()
    names = sort(map(x -> x[2:length(x)-1],split(open(f->read(f, String), "p022_names.txt"), ",")))
    reduce((s, (i, x)) -> s + (i * reduce((s, n)-> s+(Int(n)-64), x, init=0)), zip(1:length(names), names), init=0)
end

end
