#!/usr/bin/env ruby
# frozen_string_literal: true

require 'json'

# ===== JSON 生成（Ruby 对象 → JSON 字符串） =====
# JSON.generate 将 Ruby 数组/哈希转为 JSON 字符串
# JSON.pretty_generate 格式化输出，便于阅读
books = [
  { title: 'Ruby 实战', author: '张三', price: 89 },
  { title: 'Rails 权威指南', author: '李四', price: 128 }
]

json_str = JSON.pretty_generate(books)
puts "--- JSON.pretty_generate 输出 ---"
puts json_str

# ===== JSON 解析（JSON 字符串 → Ruby 对象） =====
# JSON.parse 将 JSON 字符串转为 Ruby 哈希/数组
# 注意：JSON 的 null 在 Ruby 中转为 nil
json_input = '{"name": "RubyConf", "year": 2024, "online": false, "tags": null}'
parsed = JSON.parse(json_input)

puts "--- JSON.parse 结果 ---"
puts "活动名: #{parsed['name']}"
puts "年份: #{parsed['year']}"
puts "是否在线: #{parsed['online']}"
puts "标签: #{parsed['tags'].inspect}"  # nil

# ===== 与文件结合：持久化数据 =====
# 先写入 JSON 文件，再读取解析
File.write('conference.json', JSON.pretty_generate(parsed))
loaded = JSON.parse(File.read('conference.json'))
puts "--- 文件持久化验证 ---"
puts "从文件加载: #{loaded['name']}, #{loaded['year']}"

# 清理测试文件
File.delete('conference.json') if File.exist?('conference.json')