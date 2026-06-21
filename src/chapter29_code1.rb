# article.rb — 文章模型（完整版）
# 为什么用类变量存储：简单场景下避免数据库依赖，便于学习和快速原型
# 生产环境应换用 SQLite/PostgreSQL + ActiveRecord

class Article
  attr_accessor :title, :content
  attr_reader :id, :created_at

  @@articles = []
  @@next_id = 1

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
      # 按创建时间倒序，最新文章排在最前
      @@articles.sort_by { |a| -a.created_at.to_i }
    end

    def find(id)
      @@articles.find { |a| a.id == id }
    end

    def create(title:, content:)
      article = new(title: title, content: content)
      @@articles << article
      article
    end

    def delete(id)
      article = find(id)
      @@articles.delete(article) if article
    end
  end

  # 实例方法：返回摘要（前 100 字符）
  def summary
    return content if content.length <= 100
    content[0, 100] + '...'
  end

  # 【本章新增】更新文章内容
  # 为什么返回 self：方便链式调用 Article.find(id).update(title:..., content:...)
  def update(title:, content:)
    @title = title
    @content = content
    self
  end
end