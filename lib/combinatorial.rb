module Math
  def self.factorial(n)
    return n if 1 == n
    n.downTo(1)
  end

  def self.choose(x,y)
    factorial(x) / (factorial(y) * factorial(x - y))
  end
end
