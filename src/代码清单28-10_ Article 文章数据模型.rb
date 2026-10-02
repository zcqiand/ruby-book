# article.rb — 文章模型
# 为什么用类而不是哈希：Ruby 纯面向对象，用类封装数据和行为是最佳实践
# 这样可以利用继承、模块等特性扩展功能

class Article
  # 访问器方法：让外部代码可以读写这些属性
  attr_accessor :title, :content, :created_at
  
  # 类变量：存储所有文章（简单内存存储，生产环境会换用数据库）
  @@articles = []
  @@next_id = 1
  
  # 初始化方法：创建新文章时自动调用
  def initialize(title:, content:)
    @title = title
    @content = content
    @created_at = Time.now
    @id = @@next_id
    @@next_id += 1
  end
  
  # 类方法：操作所有文章的集合
  class << self
    def all
      # 按创建时间倒序排列，最新文章在前
      @@articles.sort_by { |a| -a.created_at.to_i }
    end
    
    def find(id)
      # 根据 ID 查找文章（ID 是整数，从 1 开始）
      @@articles.find { |a| a.id == id }
    end
    
    def create(title:, content:)
      article = new(title: title, content: content)
      @@articles << article
      article
    end
    
    def delete(id)
      # 删除后返回被删除的文章（如果存在）
      article = find(id)
      @@articles.delete(article) if article
    end
  end
  
  # 实例方法：返回 ID（只读，不能修改）
  def id
    @id
  end
  
  # 实例方法：返回摘要（前 100 个字符）
  def summary
    return content if content.length <= 100
    content[0, 100] + '...'
  end
end