# test_article.rb — 验证文章模型是否正常工作

require_relative 'article'

puts "=== 创建文章 ==="
article1 = Article.create(
  title: 'Ruby 入门第一课',
  content: 'Ruby 是一种简洁优雅的编程语言，适合 Web 开发。'
)
puts "创建文章：#{article1.title} (ID: #{article1.id})"

article2 = Article.create(
  title: 'Sinatra 框架简介',
  content: 'Sinatra 是一个轻量级的 Ruby Web 框架，非常适合学习 Web 开发。'
)
puts "创建文章：#{article2.title} (ID: #{article2.id})"

puts "\n=== 文章列表 ==="
Article.all.each do |article|
  puts "- #{article.title}: #{article.summary}"
end

puts "\n=== 查找文章 ==="
found = Article.find(1)
puts "查找 ID=1：#{found.title}"

puts "\n=== 删除文章 ==="
deleted = Article.delete(1)
puts "删除：#{deleted.title}"
puts "剩余文章数：#{Article.all.size}"