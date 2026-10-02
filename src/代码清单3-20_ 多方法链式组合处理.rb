text = "Hello, World!"

# 链式：全部小写 → 替换逗号为冒号 → 去除空格 → 转大写
result = text.downcase.gsub(",", ":").gsub(" ", "").upcase

puts result
# 输出：HELLO:WORLD!