class ContactManager
  def initialize
    # 使用数组存储所有联系人对象
    # 数组是有序集合，适合按插入顺序遍历
    @contacts = []
  end
  
  # 添加联系人
  def add_contact(contact)
    @contacts << contact
  end
  
  # 列出所有联系人（简洁版）
  def list_contacts
    @contacts.each do |contact|
      puts "#{contact.name} - #{contact.phone}"
    end
  end
  
  # 按姓名模糊查询
  # 使用 find 方法返回第一个匹配的元素
  # include? 方法实现模糊匹配，不区分大小写
  def find_by_name(name)
    @contacts.find { |c| c.name.include?(name) }
  end
end

# 使用示例
manager = ContactManager.new
manager.add_contact(contact1)
manager.add_contact(contact2)
puts "所有联系人："
manager.list_contacts
puts "查询'张'："
puts manager.find_by_name('张')&.phone