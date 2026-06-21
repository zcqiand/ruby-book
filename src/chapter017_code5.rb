# Team 通过 include Enumerable 获得所有枚举能力
# 为什么只需实现 each：Enumerable 的所有方法都建立在迭代器模式上
class Team
  include Enumerable

  attr_reader :members

  def initialize
    @members = []
  end

  # 唯一需要实现的方法，其他枚举方法全部继承
  def each(&block)
    @members.each(&block)
  end

  def add(member)
    @members << member
  end
end

team = Team.new
team.add({ name: "Alice", role: "Engineer" })
team.add({ name: "Bob", role: "Designer" })
team.add({ name: "Carol", role: "Engineer" })

puts "团队成员遍历："
team.each { |m| puts "  #{m[:name]} - #{m[:role]}" }

# Enumerable 自动赋予的方法示例
engineers = team.select { |m| m[:role] == "Engineer" }
puts "\n工程师: #{engineers.map { |e| e[:name] }.join(', ')}"

names = team.map { |m| m[:name] }
puts "所有名字: #{names.join(', ')}"

count = team.count { |m| m[:role] == "Engineer" }
puts "工程师人数: #{count}"