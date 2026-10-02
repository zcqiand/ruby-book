# 多条件搜索方法
def advanced_search(criteria = {})
  return [false, '搜索条件不能为空'] if criteria.empty?

  results = @contacts.select do |contact|
    criteria.all? do |field, value|
      # 获取对应字段值
      field_value = contact.send(field)  # 动态调用方法
      # 忽略空条件的字段
      next true if value.nil? || value.to_s.strip.empty?
      # 不区分大小写的包含匹配
      field_value.to_s.downcase.include?(value.to_s.strip.downcase)
    end
  end

  if results.empty?
    [false, '未找到匹配的联系人']
  else
    [true, results]
  end
end