def calculate
  result = yield(10, 20)  # 块返回的值捕获到 result
  puts "块返回的结果是: #{result}"
end

calculate do |a, b|
  a + b                    # 块接收参数，做加法
end
# => 块返回的结果是: 30