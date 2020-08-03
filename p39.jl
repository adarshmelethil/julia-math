module p39
using Plots

function tri_counts(cap)
  top_b = cap ÷ 2
  squares = [x^2 for x in 1:top_b]
  counts = Dict{Int64, Int64}()

  for i = 1:top_b
    for j = i:top_b
      if ((cap-i-j) < ((i>j)*i + (j>i)*j))
        break
      end

      x = squares[i]
      y = squares[j]
      k = findfirst(v->v==x+y, squares)
      if k == nothing
        continue
      end

      p = i + j + k
      if haskey(counts, p)
        counts[p] += 1
      else
        counts[p] = 1
      end
    end
  end

  return counts
end

function ans()
  counts = tri_counts(1000)
  highest_p = 0
  highest_count = 0
  for (pp, count) in counts
    if count > highest_count
      highest_p = pp
      highest_count = count
    end
  end

  println(highest_p)
end

function plot_count()
  counts = tri_counts(1000)

  sorted_counts = sort(collect(counts), by=x->x[1])
  kk = []; vv = []
  for i in 1:length(sorted_counts)
    k = sorted_counts[i][1]
    v = sorted_counts[i][2]
    append!(kk, k)
    append!(vv, v)
  end
  Plots.plot(kk, vv)
end

function ans2(cap)
  squares = [x^2 for x in 1:cap]
  counts = Dict{Int64, Int64}()

  for (h, hh) in enumerate(squares)
    for x in h:-1:2
      yy = hh - x^2
      y = findfirst(v->v==yy, squares)
      if y == nothing
        continue
      end

      p = x + y + h
      if p > cap
        continue
      end
      if haskey(counts, p)
        counts[p] += 1
      else
        counts[p] = 1
      end

    end
  end
 
  highest_p = 0
  highest_count = 0
  for (pp, count) in counts
    if count > highest_count
      highest_p = pp
      highest_count = count
    end
  end

  return highest_p
end
end
# @time p39.ans()
