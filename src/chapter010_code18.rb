def compose(f, g)
  lambda { |x| f.call(g.call(x)) }
end

square = ->(x) { x ** 2 }
double = ->(x) { x * 2 }

square_then_double = compose(double, square)

puts square_then_double.call(3)
# 等价于 double(square(3)) = double(9) = 18