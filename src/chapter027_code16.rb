require 'json'
require 'securerandom'
require 'fileutils'

class Contact
  attr_reader :id, :created_at
  attr_accessor :name, :phone, :email, :address, :vip

  def initialize(id: SecureRandom.uuid, name:, phone:, email: '', address: '', vip: false)
    @id = id
    @name = name
    @phone = phone
    @email = email
    @address = address
    @vip = vip
    @created_at = Time.now
  end

  def to_h
    {
      id: @id,
      name: @name,
      phone: @phone,
      email: @email,
      address: @address,
      vip: @vip,
      created_at: @created_at.to_i
    }
  end

  def self.from_h(hash)
    contact = new(
      id: hash[:id] || SecureRandom.uuid,
      name: hash[:name],
      phone: hash[:phone],
      email: hash[:email] || '',
      address: hash[:address] || '',
      vip: hash[:vip] || false
    )
    # 如果有保存的创建时间，恢复它
    if hash[:created_at]
      contact.instance_variable_set(:@created_at, Time.at(hash[:created_at]))
    end
    contact
  end

  def to_s
    prefix = @vip ? '[VIP] ' : ''
    "#{prefix}#{@name} - #{@phone}"
  end

  def display_info
    [
      "ID: #{@id}",
      "姓名: #{@name}",
      "电话: #{@phone}",
      "邮箱: #{@email}",
      "地址: #{@address}",
      "VIP: #{@vip ? '是' : '否'}",
      "创建时间: #{@created_at.strftime('%Y-%m-%d %H:%M:%S')}"
    ].join("\n")
  end
end

class ContactManager
  def initialize
    @contacts = []
  end

  # 多条件搜索
  def advanced_search(criteria = {})
    return [false, '搜索条件不能为空'] if criteria.empty?

    results = @contacts.select do |contact|
      criteria.all? do |field, value|
        next true if value.nil? || value.to_s.strip.empty?
        field_value = contact.send(field).to_s
        field_value.downcase.include?(value.to_s.strip.downcase)
      end
    end

    [true, results]
  end

  # 正则表达式搜索
  def regex_search(criteria = {})
    return [false, '搜索条件不能为空'] if criteria.empty?

    results = @contacts.select do |contact|
      criteria.all? do |field, pattern|
        field_value = contact.send(field).to_s

        if pattern.is_a?(Regexp)
          field_value =~ pattern
        elsif pattern.is_a?(String) && pattern.start_with?('/')
          flags = pattern[-1] == 'i' ? Regexp::IGNORECASE : 0
          regex = Regexp.new(pattern[1..-3], flags)
          field_value =~ regex
        else
          field_value.downcase.include?(pattern.downcase)
        end
      end
    end

    [true, results]
  end

  # 搜索并排序
  def search_and_sort(criteria: {}, sort_by: :name, order: :asc)
    # 搜索
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

    # 排序
    if results.size > 1
      case order
      when :asc
        results.sort_by! { |c| c.send(sort_by) }
      when :desc
        results.sort_by! { |c| c.send(sort_by) }.reverse!
      end
    end

    [true, results]
  end

  # 分页
  def paginate(items, page: 1, page_size: 20)
    return [false, '数据不能为空'] if items.nil? || items.empty?

    page = page.to_i
    page_size = page_size.to_i
    page = 1 if page < 1
    page_size = 20 if page_size < 1

    total_items = items.size
    total_pages = (total_items.to_f / page_size).ceil

    start_index = (page - 1) * page_size
    end_index = [start_index + page_size, total_items].min

    page_items = items[start_index...end_index]

    {
      items: page_items,
      pagination: {
        current_page: page,
        page_size: page_size,
        total_items: total_items,
        total_pages: total_pages,
        has_prev: page > 1,
        has_next: page < total_pages
      }
    }
  end

  # 完整搜索+排序+分页
  def search_with_pagination(criteria: {}, sort_by: :name, order: :asc, page: 1, page_size: 20)
    success, results = search_and_sort(criteria: criteria, sort_by: sort_by, order: order)
    return [false, results] unless success

    paginated = paginate(results, page: page, page_size: page_size)
    [true, paginated]
  end

  # 其他基础方法（略，与第26章相同）
  def add_contact(contact)
    if @contacts.any? { |c| c.phone == contact.phone }
      return [false, "电话 #{contact.phone} 已存在"]
    end
    @contacts << contact
    [true, contact]
  end

  def list_contacts
    [true, @contacts.sort_by(&:name)]
  end

  def find_by_id(id)
    @contacts.find { |c| c.id == id }
  end

  def delete_contact(id)
    index = @contacts.find_index { |c| c.id == id }
    return [false, '未找到'] unless index
    deleted = @contacts.delete_at(index)
    [true, deleted]
  end

  def save_to_file(filename)
    FileUtils.mkdir_p(File.dirname(filename))
    temp_file = "#{filename}.#{Process.pid}.tmp"
    File.write(temp_file, JSON.pretty_generate(@contacts.map(&:to_h)), encoding: 'UTF-8')
    begin
      File.rename(temp_file, filename)
    rescue Errno::EXDEV
      FileUtils.cp(temp_file, filename)
      File.delete(temp_file)
    end
    [true, "已保存 #{@contacts.size} 条"]
  end

  def load_from_file(filename)
    return [true, '文件不存在'] unless File.exist?(filename)
    data = JSON.parse(File.read(filename, encoding: 'UTF-8'))
    @contacts = data.map { |item| Contact.from_h(item) }
    [true, "已加载 #{@contacts.size} 条"]
  end
end