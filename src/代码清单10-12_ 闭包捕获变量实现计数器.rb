def create_counter
  count = 0  # 这是外部变量
  return lambda { count += 1 }
end

counter = create_counter
puts counter.call  # => 1
puts counter.call  # => 2
puts counter.call  # => 3