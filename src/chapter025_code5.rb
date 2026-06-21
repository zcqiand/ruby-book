require 'json'

# 将联系人列表序列化为 JSON 文件
# 使用 pretty_generate 生成格式化后的 JSON，便于人工阅读和调试
def save_contacts(contacts, filename)
  # 将每个 Contact 对象转换为哈希，再组成数组
  data = contacts.map(&:to_h)
  # File.write 原子性地写入文件
  File.write(filename, JSON.pretty_generate(data))
end

# 从 JSON 文件恢复联系人列表
def load_contacts(filename)
  # 文件不存在时返回空数组，避免异常
  return [] unless File.exist?(filename)
  # 解析 JSON 字符串为 Ruby 数组（元素是哈希）
  data = JSON.parse(File.read(filename))
  # 将每个哈希转换回 Contact 对象
  data.map do |c|
    Contact.new(
      name: c['name'],
      phone: c['phone'],
      email: c['email'],
      address: c['address']
    )
  end
end

# 测试持久化流程
puts "保存联系人..."
save_contacts([contact1, contact2], 'contacts.json')

puts "从文件加载联系人..."
loaded = load_contacts('contacts.json')
loaded.each(&:display_info)