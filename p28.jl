module p28


function ans(stop_dim)
    cur_digit = 1
    cur_dim = 1
    diag_sum = 1

    while cur_dim+2 <= stop_dim
        cur_dim += 2

        # cur_digit + (cur_dim-1)
        # cur_digit + 2*(cur_dim-1)
        # cur_digit + 3*(cur_dim-1)
        # cur_digit + 4*(cur_dim-1)

        diag_sum += 4*cur_digit + 10*cur_dim-10
        cur_digit += (cur_dim-1) * 4

        # println(cur_dim, ": ", cur_digit)
    end
    return diag_sum
end

end
