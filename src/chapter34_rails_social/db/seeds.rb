# frozen_string_literal: true

# 种子数据：生成测试用关注关系
# 使用 FactoryBot 生成大量数据时，此脚本用于基础数据初始化
puts "创建测试用户和关注关系..."

# 创建测试用户
users = 10.times.map do |i|
  User.create!(
    username: "用户#{i + 1}",
    email: "user#{i + 1}@example.com",
    password: 'password123',
    bio: "这是用户 #{i + 1} 的简介"
  )
end

puts "创建了 #{users.count} 个用户"

# 建立关注关系：每个用户关注 3-7 个随机用户
users.each_with_index do |user, index|
  # 随机选择要关注的用户（不包括自己）
  other_users = users.reject { |u| u.id == user.id }.sample(rand(3..7))

  other_users.each do |target|
    user.follow(target)
  rescue ActiveRecord::RecordNotUnique
    # 忽略重复关注（事务并发时可能出现）
    puts "  #{user.username} 已关注 #{target.username}"
  end

  puts "#{user.username} 关注了 #{other_users.count} 人"
end

# 生成一些帖子
users.each do |user|
  rand(2..5).times do |i|
    user.posts.create!(
      content: "#{user.username} 的第 #{i + 1} 篇测试帖子内容"
    )
  end
end

puts "种子数据创建完成！"
puts "关注关系总数: #{Follow.count}"
puts "帖子总数: #{Post.count}"
