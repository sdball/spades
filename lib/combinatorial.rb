module Math
  def self.factorial(n)
    return n if 1 == n
    return n if 2 == n
    (2..n).inject(:*)
  end

  def self.choose(x,y)
    factorial(x) / (factorial(y) * factorial(x - y))
  end
end
