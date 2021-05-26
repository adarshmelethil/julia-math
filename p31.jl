module p31
using Memoize

function ans()
    coins = Int[1, 2, 5, 10, 20, 50, 100]
    val = 200
end

function brute_add(coins, cur_coins, val, last_coin)
    for coin in reverse(coins)
        if coin >= last_coin
            continue
        end
        if coin > val || (sum(cur_coins)+coin) > val
            continue
        end
        push!(cur_coins, coin)
        return true
    end
    return false
end
function brute(coins, val)
    count = 0
    cur_coins = Int[]
    last_coin = last(coins)+1
    while true
        if !brute_add(coins, cur_coins, val, last_coin)
            if length(cur_coins) == 0
                return count
            end
            last_coin = pop!(cur_coins)
        end
        if sum(cur_coins) == val
            count += 1
        end
    end
    return count
end

function csum(stack; l=nothing)
    counter = 1
    i = length(stack)
    while true
        if i == 0
            return counter
        end
        if stack[i] == 1
            i -= 1
            continue
        end
        stack[i] -= 1
        for j in i:length(stack)
            stack[j] = stack[i]
            if j == length(stack) && l != nothing
                stack[j] = l
            end
        end
        counter += 1
        i = length(stack)
    end
end
function count_coins(coins, val)
    # [20, 50, 100], 200
    # 200


    # 200 - 100 100, 100 50 50, 50 50 50 50
    # 100 - 50 50
    # 50 - 20 20 R10

    # single_coins = [( ? val÷c : 0 ) for c in coins]

    if length(coins) == 0 || val == 0
        return 0
    end

    largest_coin = last(coins)
    if largest_coin > val
        return count_coins(coins[2:lenght(coins)], val)
    end

    largest_fit = val ÷ largest_coin
    largest_left = val % largest_coin

    cur_count_fit = count_coins(coins[2:length(coins)], largest_coin)
    left_count = count_coins(coins[2:length(coins)], largest_left)

    coin_stack = Int[cur_count_fit for _ in 1:largest_fit-1]
    if largest_left != 0
        push!(coin_stack, left_count)
    end
    stack_sum = csum(coin_stack; l=(largest_left==0) ? nothing : largest_left )
    for c in coins
        if val % c == 0
            stack_sum += 1
        end
    end

    return stack_sum
end

end
