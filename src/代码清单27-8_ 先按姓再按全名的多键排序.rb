# 多键排序：先按姓（name的第一个字），再按全名
sorted = @contacts.sort_by do |c|
  # 返回一个数组，第一个元素是主键，第二个是副键
  [c.name.chars.first, c.name]
end

# 效果：先按姓氏分组，组内再按全名排序