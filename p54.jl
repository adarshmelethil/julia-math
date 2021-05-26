module p54

function nth_geometric_sum(b, n)
    Int((1 - b^(n+1)) / (1 - b))
end

single_card_score(hand) = reduce((s,x)->s+x[1], hand, init=0)
# 1 pair
# 1 - 1     -> 2*1 = 2
# 2 - 3     -> 2*2 = 6
function card_score(hand; debug=false)
    # AKQJT
    # pair2_base = Int((14+10)*(5/2))
    pair2_base = 14 + 13 + 12 + 11 + 10
    # AAKKQ
    pair3_base = (pair2_base*14) + (pair2_base*13) + 12
    # AAAKQ
    straight_base = (pair3_base*14) + 13 + 12
    # AKQJT
    flush_base = (straight_base * 10)
    # AKQJ9
    fullhouse_base = (flush_base * 14 * 13 * 12 * 11 * 9)
    # AAAKK
    pair4_base = (fullhouse_base * 14) + (pair2_base * 13)
    # AAAAK
    straight_flush_base = (pair4_base * 14) + 13
    # AKQJT highest straight_flush
    # royal_flush_base = (straight_flush_base + 10)

    # check dups
    hand_values = map(x->x[1], hand)
    card_dup = sort(map(i->(i, count(x->x==i,hand_values)), unique(hand_values)), by=x->x[2], rev=true)
    # check straight
    sorted_hand = sort(hand, by=x->x[1])
    straight = true
    flush = true
    for card_i in 2:5
        if sorted_hand[card_i][1] - sorted_hand[card_i-1][1] != 1
            straight = false
        end
        if sorted_hand[card_i][2] != sorted_hand[1][2]
            flush = false
        end
    end

    if debug
        println(sorted_hand)
        println(card_dup)
    end
    if flush && straight
        if debug
            println("Straight flush: $(sorted_hand[1][1])")
        end
        return straight_flush_base * sorted_hand[1][1]
    elseif length(card_dup) == 2 && card_dup[1][2] == 4
        if debug
            println("4-pair: $(card_dup[1][1])")
        end
        return (pair4_base * card_dup[1][1]) + card_dup[2][1]
    elseif length(card_dup) == 2 && card_dup[1][2] == 3
        if debug
            println("full house: $(card_dup[1][1]), $(card_dup[2][1])")
        end
        return (fullhouse_base * card_dup[1][1]) + (pair2_base * card_dup[2][1])
    elseif flush
        if debug
            println("flush")
        end
        return reduce(*, map(c->c[1],hand), init=flush_base)
    elseif straight
        if debug
            println("straight: $(sorted_hand[1][1])")
        end
        return straight_base * sorted_hand[1][1]
    elseif length(card_dup) == 3 && card_dup[1][2] == 3
        if debug
            println("3-pair: $(sorted_hand[1][1])")
        end
        return (pair3_base * sorted_hand[1][1]) + sorted_hand[2][1] + sorted_hand[3][1]
    elseif length(card_dup) == 3
        if debug
            println("2 2-pair: $(card_dup[1][1]), $(card_dup[2][1])")
        end
        return (pair2_base * card_dup[1][1]) + (pair2_base * card_dup[2][1]) + card_dup[3][1]
    elseif length(card_dup) == 4
        if debug
            println("1 2-pair $(card_dup[1][1])")
        end
        return (pair2_base * card_dup[1][1]) + card_dup[2][1] + card_dup[3][1] + card_dup[4][1]
    else
        if debug
            println("High card")
        end
        return reduce(+, map(c->c[1],hand), init=0)
    end
end


function better_hand(hand1, hand2; debug=false)
    hand1_score = card_score(hand1;debug=debug)
    hand2_score = card_score(hand2;debug=debug)
    if debug
        println("h1: $(hand1_score)")
        println("h2: $(hand2_score)")
    end

    hand1_score > hand2_score
    # single_card_score(hand1) >
    #     single_card_score(hand2)
end

function str_to_card(hand)
    findfirst(x->x==hand[1], "123456789TJQKA"),
    findfirst(x->x==hand[2], "CHSD")
end

function str_to_hands(l)
    cards = map(str_to_card, split(strip(l), " "))
    return cards[1:5], cards[6:10]
end

function ans()
    open("p054_poker.txt") do file
        # count(map(hs->better_hand(str_to_hands(hs)...), eachline(file)))
        for line in eachline(file)
            a = better_hand(str_to_hands(line)...; debug=true)
            println("$(line) = $(a)")
            readline()
        end
    end
end

test_cases = [
    ("5H 5C 6S 7S KD 2C 3S 8S 8D TD", false),
    ("5D 8C 9S JS AC 2C 5C 7D 8S QH", true),
    ("2D 9C AS AH AC 3D 6D 7D TD QD", false),
    ("4D 6S 9H QH QC 3D 6D 7H QD QS", true),
    ("2H 2D 4C 4D 4S 3C 3D 3S 9S 9D", true),
]
function t()
    for (hands_str, win) in test_cases
        if better_hand(str_to_hands(hands_str)...) != win
            println(hands_str)
            better_hand(str_to_hands(hands_str)...; debug=true)
        end
    end
    # a = better_hand(str_to_hands(t2)...)
    # println(a)
end
end
