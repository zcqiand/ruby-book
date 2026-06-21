# article.rb — 文章模型（完整版）
# 类变量 @@articles 存储所有文章（简单场景下避免数据库依赖）
# 生产环境建议换用 SQLite/PostgreSQL + ActiveRecord

class Article
  # attr_accessor 生成 getter/setter，attr_reader 只生成 getter
  # 为什么 title 和 content 用 accessor（可读写），id 和 created_at 用 reader（只读）
  # 因为 id 在创建后不应该改变，created_at 也不应该被随意修改
  attr_accessor :title, :content
  attr_reader :id, :created_at

  # 类变量：存储所有文章实例
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
      # 按创建时间倒序排列，最新文章排在前面
      @@articles.sort_by { |a| -a.created_at.to_i }
    end

    def find(id)
      # find_by_id 的简写：通过 ID 查找文章
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

  # 实例方法：返回文章摘要（前 100 个字符）
  def summary
    return content if content.length <= 100
    content[0, 100] + '...'
  end

  # 【本章新增】更新文章内容
  # 为什么返回 self：方便链式调用，也符合 Ruby 的惯例
  def update(title:, content:)
    @title = title
    @content = content
    self
  end
end