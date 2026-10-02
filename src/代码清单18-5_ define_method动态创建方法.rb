class MyClass
  define_method(:greet) do |name|
    "你好，#{name}！"
  end
end

obj = MyClass.new
puts obj.greet("Alice")  # => "你好，Alice！"