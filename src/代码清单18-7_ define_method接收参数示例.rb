class Calculator
  define_method(:add) do |a, b|
    a + b
  end

  define_method(:power) do |base, exponent = 2|
    base ** exponent
  end
end

calc = Calculator.new
puts calc.add(2, 3)        # => 5
puts calc.power(2, 3)     # => 8
puts calc.power(2)        # => 4（使用默认值）