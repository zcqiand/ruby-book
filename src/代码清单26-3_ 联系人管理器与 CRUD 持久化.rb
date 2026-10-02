# ContactManager 类 - 联系人集合的全功能管理器
# 支持 CRUD 操作与 JSON 文件持久化
class ContactManager
  # 文件不存在时返回空数组，保证加载的健壮性
  def initialize
    @contacts = []
  end

  # CREATE: 添加新联系人
  # 重复判断：基于电话唯一性
  def add_contact(contact)
    if @contacts.any? { |c| c.phone == contact.phone }
      return [false, "添加失败: 电话 #{contact.phone} 已存在"]
    end

    @contacts << contact
    [true, "已添加联系人: #{contact.name} (ID: #{contact.id})"]
  end

  # READ: 列出所有联系人
  def list_contacts
    if @contacts.empty?
      return [false, '暂无联系人']
    end

    sorted = @contacts.sort_by(&:name)
    lines = ["共 #{sorted.size} 位联系人:", '-' * 40]
    sorted.each_with_index do |contact, index|
      lines << "#{index + 1}. #{contact.to_s}"
    end
    [true, lines.join("\n")]
  end

  # READ: 根据ID查找单个联系人
  def find_by_id(id)
    @contacts.find { |c| c.id == id }
  end

  # READ: 根据ID查找并返回详细信息
  def get_contact(id)
    contact = find_by_id(id)
    if contact
      [true, contact.display_info]
    else
      [false, "未找到 ID 为 #{id} 的联系人"]
    end
  end

  # UPDATE: 更新联系人信息
  def update_contact(id, attributes)
    contact = find_by_id(id)
    unless contact
      return [false, "更新失败: 未找到 ID 为 #{id} 的联系人"]
    end

    # 如果新电话与已有联系人冲突（排除自身）
    if attributes.key?(:phone) && attributes[:phone] != contact.phone
      if @contacts.any? { |c| c.phone == attributes[:phone] && c.id != id }
        return [false, "更新失败: 电话 #{attributes[:phone]} 已被其他联系人使用"]
      end
    end

    contact.update(attributes)
    [true, contact]
  end

  # DELETE: 删除联系人（硬删除，重写整个文件）
  # 决策依据：数据量小、写操作不频繁、模型干净、避免累积已删除标记
  def delete_contact(id)
    index = @contacts.find_index { |c| c.id == id }
    unless index
      return [false, "删除失败: 未找到 ID 为 #{id} 的联系人"]
    end

    deleted = @contacts.delete_at(index)
    [true, "已删除联系人: #{deleted.name}"]
  end

  # SEARCH: 灵活搜索（按姓名或电话模糊匹配）
  def search(query)
    return [false, '搜索关键词不能为空'] if query.to_s.strip.empty?

    normalized_query = query.to_s.strip.downcase
    results = @contacts.select do |c|
      c.name.downcase.include?(normalized_query) ||
        c.phone.include?(normalized_query) ||
        c.email.downcase.include?(normalized_query)
    end

    if results.empty?
      [false, "未找到包含「#{query}」的联系人"]
    else
      lines = ["找到 #{results.size} 条结果:", '-' * 40]
      results.each { |c| lines << c.to_s }
      [true, lines.join("\n")]
    end
  end

  # PERSISTENCE: 保存到 JSON 文件
  # 使用原子写入模式：先写临时文件再 rename，防止写入失败导致数据损坏
  def save_to_file(filename)
    FileUtils.mkdir_p(File.dirname(filename))

    temp_file = "#{filename}.#{Process.pid}.tmp"
    File.write(temp_file, JSON.pretty_generate(@contacts.map(&:to_h)), encoding: 'UTF-8')

    # Windows 不支持原子 rename（跨文件系统），fallback 到直接覆盖
    begin
      File.rename(temp_file, filename)
    rescue Errno::EXDEV
      FileUtils.cp(temp_file, filename)
      File.delete(temp_file)
    end

    [true, "已保存 #{@contacts.size} 位联系人的数据"]
  rescue => e
    [false, "保存失败: #{e.message}"]
  end

  # PERSISTENCE: 从 JSON 文件加载
  def load_from_file(filename)
    return [true, '数据文件不存在，已初始化空列表'] unless File.exist?(filename)

    begin
      content = File.read(filename, encoding: 'UTF-8')
      data = JSON.parse(content)

      unless data.is_a?(Array)
        return [false, '加载失败: 文件格式错误，期望数组']
      end

      @contacts = data.map { |item| Contact.from_h(item) }
      [true, "已加载 #{@contacts.size} 位联系人"]
    rescue JSON::ParserError => e
      [false, "加载失败: JSON 解析错误 - #{e.message}"]
    rescue => e
      [false, "加载失败: #{e.message}"]
    end
  end

  # 统计信息
  def count
    @contacts.size
  end
end