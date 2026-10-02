require 'json'

# Ruby对象转JSON字符串
data = { name: "张三", age: 30, skills: ["Ruby", "Python"] }
json_string = JSON.generate(data)
puts json_string
# => {"name":"张三","age":30,"skills":["Ruby","Python"]}

# JSON字符串转Ruby对象
parsed = JSON.parse(json_string)
puts parsed["name"]  # => 张三