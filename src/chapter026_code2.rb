require 'json'
require 'securerandom'
require 'fileutils'

# Contact 类 - 代表单个联系人
# 使用 UUID 作为唯一标识符，便于分布式场景下的去重与查找
class Contact
  attr_reader :id
  attr_accessor :name, :phone, :email, :address

  def initialize(id: SecureRandom.uuid, name:, phone:, email: '', address: '')
    @id = id
    @name = name
    @phone = phone
    @email = email
    @address = address
  end

  # 显示联系人完整信息
  def display_info
    [
      "ID: #{@id}",
      "姓名: #{@name}",
      "电话: #{@phone}",
      "邮箱: #{@email}",
      "地址: #{@address}"
    ].join("\n")
  end

  # 转为哈希，用于 JSON 序列化
  # 注意：id 作为键包含在哈希中，加载时用于重建对象
  def to_h
    {
      id: @id,
      name: @name,
      phone: @phone,
      email: @email,
      address: @address
    }
  end

  # 从哈希重建 Contact 对象（类方法）
  def self.from_h(hash)
    raise ArgumentError, '缺少必填字段: name' unless hash.key?(:name) && hash[:name]
    raise ArgumentError, '缺少必填字段: phone' unless hash.key?(:phone) && hash[:phone]

    new(
      id: hash[:id] || SecureRandom.uuid,
      name: hash[:name],
      phone: hash[:phone],
      email: hash[:email] || '',
      address: hash[:address] || ''
    )
  end

  # 简览字符串
  def to_s
    "#{@name} - #{@phone}"
  end

  # 更新属性（批量）
  def update(attributes)
    @name = attributes[:name] if attributes.key?(:name)
    @phone = attributes[:phone] if attributes.key?(:phone)
    @email = attributes[:email] if attributes.key?(:email)
    @address = attributes[:address] if attributes.key?(:address)
    self
  end
end