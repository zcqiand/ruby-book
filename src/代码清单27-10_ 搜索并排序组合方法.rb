# 搜索并排序的组合方法
def search_and_sort(criteria: {}, sort_by: :name, order: :asc)
  # 第一步：应用搜索条件
  results = if criteria.empty?
    @contacts.dup
  else
    @contacts.select do |contact|
      criteria.all? do |field, value|
        next true if value.nil? || value.to_s.strip.empty?
        field_value = contact.send(field).to_s
        field_value.downcase.include?(value.to_s.strip.downcase)
      end
    end
  end

  # 第二步：应用排序
  if results.size > 1
    results = case order
    when :asc
      results.sort_by { |c| c.send(sort_by) }
    when :desc
      results.sort_by { |c| c.send(sort_by) }.reverse
    else
      results
    end
  end

  [true, results]
end