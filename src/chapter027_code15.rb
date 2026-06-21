# 建立姓名到联系人的哈希索引
@name_index = {}
@contacts.each do |c|
  # 姓名全字匹配
  @name_index[c.name.downcase] = c
  # 姓名分词索引（支持「张三」搜「三」）
  c.name.chars.each do |char|
    @name_index[char] ||= []
    @name_index[char] << c
  end
end