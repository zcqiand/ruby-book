# 搜索「张」，每页20条，获取第3页
success, result = manager.search_with_pagination(
  criteria: { name: '张' },
  sort_by: :name,
  order: :asc,
  page: 3,
  page_size: 20
)

if success
  puts "第 #{result[:pagination][:current_page]}/#{result[:pagination][:total_pages]} 页"
  puts "共 #{result[:pagination][:total_items]} 条结果"
  result[:items].each { |c| puts c.to_s }
end