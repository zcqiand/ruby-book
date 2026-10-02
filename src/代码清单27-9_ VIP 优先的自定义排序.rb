# 假设我们给Contact添加了一个vip属性
# VIP排前面，其他按姓名排序
sorted = @contacts.sort do |a, b|
  if a.vip == b.vip
    # 两者VIP状态相同，按姓名排序
    a.name <=> b.name
  else
    # VIP状态的差异决定顺序（true排前面）
    b.vip <=> a.vip
  end
end