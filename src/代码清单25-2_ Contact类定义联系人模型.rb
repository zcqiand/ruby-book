# 联系人类
class Contact
  # 使用 attr_accessor 自动生成 getter 和 setter 方法
  # 这样外部代码可以读写 name、phone、email、address 四个属性
  attr_accessor :name, :phone, :email, :address
  
  # 初始化方法，使用命名参数提升代码可读性
  # address 有默认值空字符串，因为地址信息有时可省略
  def initialize(name:, phone:, email:, address: '')
    @name = name
    @phone = phone
    @email = email
    @address = address
  end
  
  # 显示联系人完整信息的方法
  def display_info
    puts "姓名: #{@name}"
    puts "电话: #{@phone}"
    puts "邮箱: #{@email}"
    puts "地址: #{@address}"
  end
  
  # 转换为哈希的方法，用于后续的 JSON 序列化
  def to_h
    {
      name: @name,
      phone: @phone,
      email: @email,
      address: @address
    }
  end
end