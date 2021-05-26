module p36

function palindrome(arr)
    for (i, j) in zip(1:length(arr)÷2, length(arr):-1:length(arr)÷2)
        if arr[i] != arr[j]
            return false
        end
    end
    return true
end
function ans(bound)
    s = 0
    for n in 1:bound-1
        if palindrome(digits(n)) && palindrome(digits(n, base=2))
            s += n
        end
    end
    return s
end

end
