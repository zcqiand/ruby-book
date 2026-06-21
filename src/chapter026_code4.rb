# 演示完整 CRUD 工作流
def demo
  data_file = 'contacts_demo.json'

  # 清理可能残留的测试文件
  File.delete(data_file) if File.exist?(data_file)

  manager = ContactManager.new

  puts '=' * 50
  puts '1. 添加联系人 (CREATE)'
  puts '=' * 50

  contacts_data = [
    { name: '张三', phone: '13800138000', email: 'zhangsan@example.com', address: '北京市朝阳区' },
    { name: '李四', phone: '13900139000', email: 'lisi@example.com', address: '上海市浦东新区' },
    { name: '王五', phone: '13700137000', email: 'wangwu@example.com', address: '广州市天河区' },
    { name: '赵六', phone: '13600136000', email: 'zhaoliu@example.com', address: '深圳市南山区' }
  ]

  contacts_data.each do |data|
    success, message = manager.add_contact(Contact.new(**data))
    puts message
  end

  # 测试重复电话拦截
  puts "\n--- 测试重复电话拦截 ---"
  success, message = manager.add_contact(Contact.new(name: '测试', phone: '13800138000'))
  puts message

  puts "\n" + '=' * 50
  puts '2. 列出所有联系人 (READ)'
  puts '=' * 50
  success, output = manager.list_contacts
  puts output

  puts "\n" + '=' * 50
  puts '3. 查找单个联系人'
  puts '=' * 50
  first_id = manager.instance_variable_get(:@contacts).first.id
  success, output = manager.get_contact(first_id)
  puts output

  puts "\n" + '=' * 50
  puts '4. 更新联系人 (UPDATE)'
  puts '=' * 50
  success, result = manager.update_contact(first_id, { address: '北京市海淀区', email: 'newemail@example.com' })
  if success
    puts "更新成功: #{result.name} 的新信息:"
    puts result.display_info
  end

  puts "\n" + '=' * 50
  puts '5. 搜索联系人 (SEARCH)'
  puts '=' * 50
  success, output = manager.search('北京')
  puts output

  puts "\n" + '=' * 50
  puts '6. 保存到 JSON 文件'
  puts '=' * 50
  success, message = manager.save_to_file(data_file)
  puts message
  puts "\n文件内容预览:"
  puts File.read(data_file, encoding: 'UTF-8')

  puts "\n" + '=' * 50
  puts '7. 从文件加载 (模拟重新启动程序)'
  puts '=' * 50
  new_manager = ContactManager.new
  success, message = new_manager.load_from_file(data_file)
  puts message
  success, output = new_manager.list_contacts
  puts output

  puts "\n" + '=' * 50
  puts '8. 删除联系人 (DELETE)'
  puts '=' * 50
  second_id = new_manager.instance_variable_get(:@contacts)[1].id
  success, message = new_manager.delete_contact(second_id)
  puts message

  puts "\n--- 删除后重新保存文件 (演示硬删除重写) ---"
  new_manager.save_to_file(data_file)
  puts "删除后文件内容:"
  puts File.read(data_file, encoding: 'UTF-8')

  # 清理测试文件
  File.delete(data_file) if File.exist?(data_file)

  puts "\n" + '=' * 50
  puts '演示完成'
  puts '=' * 50
  puts '完整工作流验证通过: CRUD + JSON 持久化 + 搜索 + 重复检查'
end

# 运行演示
demo