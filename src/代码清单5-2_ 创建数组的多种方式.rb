# 数字数组
numbers = [1, 2, 3, 4, 5]

# 混合类型数组
mixed = [1, 'two', 3.0]

# 空数组
empty = []

# Array.new 创建空数组（适合动态添加场景）
# 先声明再填充是常见模式，new 可指定初始值和大小
empty_arr = Array.new
puts "空数组: #{empty_arr}"
# => []

# Array.new 带块（每个元素独立，避免共享引用问题）
# 当默认值是可变对象时，用块生成独立副本更安全
unique_arr = Array.new(3) { |i| "元素#{i + 1}" }
puts "块生成独立元素: #{unique_arr}"
# => [元素1, 元素2, 元素3]

# %w 语法糖（适合字符串数组，省引号）
# 简单字符串数组时比 [] 更简洁
languages = %w[Ruby Python JavaScript Go]
puts "%w 语法: #{languages}"
# => [Ruby, Python, JavaScript, Go]

# 嵌套数组（多维数组）
matrix = [[1, 2], [3, 4], [5, 6]]
puts "嵌套数组: #{matrix[1][0]}"
# => 3