# 使用 Symbol 作为键
config = {
  name: "XR-Knowledge",
  version: "1.0",
  author: "Ruby Learner"
}

# 访问方式：支持点号语法（实际上也是 Symbol 键的语法糖）
puts "config[:name]  =>  #{config[:name]}"

# Symbol 与 String 互转
sym_to_str = :hello.to_s
str_to_sym = "world".to_sym
puts ":hello.to_s  =>  #{sym_to_str.inspect} (#{sym_to_str.class})"
puts "\"world\".to_sym  =>  #{str_to_sym.inspect} (#{str_to_sym.class})"