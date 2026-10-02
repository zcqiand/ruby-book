# 创建联系人实例
# 姓名、电话、邮箱为必填项，地址可省略
contact1 = Contact.new(
  name: '张三',
  phone: '13800138000',
  email: 'zhangsan@example.com',
  address: '北京市朝阳区'
)

contact2 = Contact.new(
  name: '李四',
  phone: '13900139000',
  email: 'lisi@example.com'
  # 地址省略，使用默认值空字符串
)

# 调用对象的显示方法
contact1.display_info
puts "---"
contact2.display_info

# 将对象转换为哈希（用于持久化或数据传输）
puts contact1.to_h