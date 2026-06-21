# ============================================================
# 1. Symbol 与 String 对比
# ============================================================

# Symbol 创建示例:
sym1 = :hello
sym2 = :"world"
sym3 = %i[foo bar]  # 用 %i 创建符号数组，字面量语法更简洁

puts "Symbol 创建示例:"
puts "sym1 = :hello  =>  #{sym1.inspect}"
puts "sym2 = :\"world\"  =>  #{sym2.inspect}"
puts "%i[foo bar]  =>  #{sym3.inspect}"

# Symbol vs String 内存对比（object_id）

# Symbol：相同内容共享同一个 object_id
sym_a1 = :ruby
sym_a2 = :ruby
puts "Symbol :ruby 两个变量 object_id 相同: #{sym_a1.object_id == sym_a2.object_id} (#{sym_a1.object_id} == #{sym_a2.object_id})"

# String：每次创建都是新对象
str_b1 = "ruby"
str_b2 = "ruby"
puts "String \"ruby\" 两个变量 object_id 相同: #{str_b1.object_id == str_b2.object_id} (#{str_b1.object_id} != #{str_b2.object_id})"

puts "\n结论：Symbol 节省内存，适合作为哈希键和枚举值"