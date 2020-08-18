module queens

function mark(n, taken_y, forward_dag, backward_dag, x, y, m, b)
    taken_y[y] = m
    forward_dag[(x-y)+n] = m
    backward_dag[(x+y)-1] = m
    b[x] = m ? y : 0
end
function check(n, taken_y, forward_dag, backward_dag, x, y)
    (taken_y[y]==false && forward_dag[(x-y)+n]==false && backward_dag[(x+y)-1]==false)
end

function print_board(b)
    for (x, y) in enumerate(b)
        for i in 1:length(b)
            if i == y
                print("✖")
            else
                print("█")
            end
        end
        println()
    end
    for _ in 1:10
        print("-")
    end
    println()
end

function rot_p(p, o)
    np = p-o

    return [
        -np[2],
        np[1],
    ] + o
end
function rot_queens(queens)
    n = length(queens)
    rotated_coor = [
        rot_p([x,y], [((n-1)/2)+1, ((n-1)/2)+1])
        for (x, y) in enumerate(queens)
    ]
    rotated = zeros(Int, n)
    for (x, y) in rotated_coor
        rotated[Int(x)] = Int(y)
    end
    return rotated
end
function hflip(queens)
    n = length(queens)
    return [
        queens[n-(i-1)]
        for i in 1:n
    ]
end
function vflip(queens)
    return [
        length(queens)-(y-1)
        for y in queens
    ]
end
function get_symmetries(queens)
    all_sym = [
        hflip(queens),
        vflip(queens)
    ]

    qs = queens
    for _ in 1:3
        qs = rot_queens(qs)
        if !(qs in all_sym)
            push!(all_sym, qs)
        end
        hqs = hflip(qs)
        if !(hqs in all_sym)
            push!(all_sym, hqs)
        end
        vqs = vflip(qs)
        if !(vqs in all_sym)
            push!(all_sym, vqs)
        end
    end
    return all_sym
end

function ans(n)
    taken_y = zeros(UInt8, n)
    forward_dag = zeros(UInt8, n+n-1) # x - y
    backward_dag = zeros(UInt8, n+n-1) # x + y
    symmetry = []

    combinations = 0
    x = 1
    ys = ones(Int8, n)

    b = [0 for _ in 1:n] # y value for each x
    while x > 0
        found = false
        for y in ys[x]:n
            if check(n, taken_y, forward_dag, backward_dag, x, y)

                mark(n, taken_y, forward_dag, backward_dag, x, y, true, b)
                found = true
                ys[x] = y
                x += 1

                if x > n && !(b in symmetry)
                    combinations += 1

                    append!(symmetry, get_symmetries(b))
                end
                break
            end
        end

        if !found
            ys[x] = 1
            x -= 1
            if x > 0
                mark(n, taken_y, forward_dag, backward_dag, x, ys[x], false, b)
                ys[x] += 1
            end
        elseif x > n
            # remove the last mark
            x -= 1
            mark(n, taken_y, forward_dag, backward_dag, x, ys[x], false, b)

            ys[x] = 1
            x -= 1
            if x > 0
                mark(n, taken_y, forward_dag, backward_dag, x, ys[x], false, b)
                ys[x] += 1
            end
        end
    end
    return combinations
end

end

# @time ans = queens.ans(8)
# println(ans)
