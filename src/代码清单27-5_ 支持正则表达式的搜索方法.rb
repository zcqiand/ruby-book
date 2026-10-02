# 支持正则表达式的搜索方法
def regex_search(criteria = {})
  return [false, '搜索条件不能为空'] if criteria.empty?

  results = @contacts.select do |contact|
    criteria.all? do |field, pattern|
      field_value = contact.send(field).to_s

      # 如果是正则表达式，直接匹配
      if pattern.is_a?(Regexp)
        field_value =~ pattern
      elsif pattern.is_a?(String) && pattern.start_with?('/')
        # 用户传入类似 "/@gmail\.com$/i" 的字符串，需要转换
        regex = Regexp.new(pattern[1..-3], pattern[-1] == 'i' ? Regexp::IGNORECASE : 0)
        field_value =~ regex
      else
        # 否则当作普通字符串包含匹配
        field_value.downcase.include?(pattern.downcase)
      end
    end
  end

  [true, results]
end