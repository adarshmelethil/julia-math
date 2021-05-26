module p55

function ans()
    max_sum = 0
    for a in 1:100
        for b in 1:100
            s = sum(digits(big(a)^b))
            if s > max_sum
                max_sum = s
            end
        end
    end
    max_sum
end

end
