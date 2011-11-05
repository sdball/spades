module Math
  def self.factorial(n)
    return 1 if 0 >= n
    return n if 1 == n
    return n if 2 == n
    (2..n).inject(:*)
  end

  def self.combinatorial(x,y)
    return 0 if y > x
    return 1 if x == y
    factorial(x) / (factorial(y) * factorial(x - y))
  end
end
