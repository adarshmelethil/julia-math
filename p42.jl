module p42

# 0 = 1/2 * n^2 + 1/2 * n - tn
function is_triangle(n)
    a, b, c = 0.5, 0.5, -n
    dd = sqrt( (b^2)-(4*a*c) )
    ans = (-b + dd)/(2*a)
    ans == floor(ans)
end

word_num(w) = reduce((s, x)->s+Int(x)-64, w, init=0)

function ans()
    words_list_file = "p042_words.txt"
    count(map(is_triangle, map(word_num, map(x -> x[2:length(x)-1], split(open(f->read(f, String), words_list_file), ",")))) )
end

end
