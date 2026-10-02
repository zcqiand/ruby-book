class QueryBuilder
  def initialize
    @conditions = []
  end

  # 拦截所有以 `where_` 开头的方法调用
  def method_missing(name, *args)
    if name.to_s.start_with?('where_')
      attribute = name.to_s.sub('where_', '')
      @conditions << { attribute.to_sym => args.first }
      self  # 返回 self，支持链式调用
    else
      super
    end
  end

  def to_sql
    where_clauses = @conditions.map do |cond|
      cond.map { |k, v| "#{k} = #{v.inspect}" }.join(' AND ')
    end.join(' AND ')

    "SELECT * FROM users WHERE #{where_clauses}"
  end
end

query = QueryBuilder.new
sql = query.where_name('Alice').where_age(30).to_sql
puts sql
# => SELECT * FROM users WHERE name = "Alice" AND age = 30