def demo_search_and_sort
  manager = ContactManager.new

  # 添加测试数据
  contacts = [
    { name: '张三', phone: '13800138000', email: 'zhangsan@gmail.com', vip: true },
    { name: '李四', phone: '13900139000', email: 'lisi@qq.com', vip: false },
    { name: '王五', phone: '13700137000', email: 'wangwu@gmail.com', vip: true },
    { name: '赵六', phone: '13600136000', email: 'zhaoliu@gmail.com', vip: false },
    { name: '张三天', phone: '13500135000', email: 'zhangsantian@163.com', vip: false },
  ]

  contacts.each do |data|
    manager.add_contact(Contact.new(**data))
  end

  puts '=' * 50
  puts '1. 多条件搜索（姓名含"张"且VIP）'
  puts '=' * 50
  success, results = manager.advanced_search({ name: '张', vip: true })
  results.each { |c| puts c.to_s }

  puts "\n" + '=' * 50
  puts '2. 正则搜索（gmail邮箱）'
  puts '=' * 50
  success, results = manager.regex_search({ email: /@gmail\.com$/i })
  results.each { |c| puts c.to_s }

  puts "\n" + '=' * 50
  puts '3. 搜索+排序（按VIP优先，再按姓名）'
  puts '=' * 50
  success, results = manager.search_and_sort(
    criteria: { name: '' },
    sort_by: :name,
    order: :asc
  )
  # 自定义排序：VIP优先
  sorted = results.sort do |a, b|
    if a.vip == b.vip
      a.name <=> b.name
    else
      b.vip <=> a.vip
    end
  end
  sorted.each { |c| puts c.to_s }

  puts "\n" + '=' * 50
  puts '4. 分页展示（每页2条，第1页）'
  puts '=' * 50
  success, result = manager.search_with_pagination(
    criteria: {},
    sort_by: :name,
    order: :asc,
    page: 1,
    page_size: 2
  )
  puts "第 #{result[:pagination][:current_page]}/#{result[:pagination][:total_pages]} 页"
  puts "共 #{result[:pagination][:total_items]} 条"
  result[:items].each { |c| puts c.to_s }
end

demo_search_and_sort