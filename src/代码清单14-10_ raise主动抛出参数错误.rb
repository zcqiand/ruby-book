def factorial(n)
  raise ArgumentError, "参数必须是非负整数" unless n.is_a?(Integer) && n >= 0

  return 1 if n <= 1
  n * factorial(n - 1)
end

begin
  factorial(-1)
rescue ArgumentError => e
  puts "参数错误: #{e.message}"
end