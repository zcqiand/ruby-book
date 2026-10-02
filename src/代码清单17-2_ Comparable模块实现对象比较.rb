# Gem 类通过 include Comparable 获得完整的比较能力
# 为什么需要 <=>：Comparable 依赖这个方法判断大小关系
class Gem
  include Comparable  # 混入比较能力

  attr_reader :carats, :name

  def initialize(name, carats)
    @name = name
    @carats = carats
  end

  # 必须实现 <=>， Comparable 的一切都建立在此之上
  def <=>(other)
    @carats <=> other.carats
  end
end

ruby = Gem.new("红宝石", 1.5)
emerald = Gem.new("祖母绿", 0.9)
diamond = Gem.new("钻石", 2.0)

puts "宝石比较（按克拉数）："
puts "红宝石 vs 祖母绿: #{ruby <=> emerald}"   # => 1
puts "红宝石 vs 钻石: #{ruby <=> diamond}"      # => -1
puts "红宝石 == 红宝石: #{ruby == ruby}"        # => true

# Comparable 自动赋予的便捷方法
gems = [ruby, emerald, diamond].sort
puts "\n按克拉升序排列: #{gems.map { |g| "#{g.name}(#{g.carats}ct)" }.join(', ')}"