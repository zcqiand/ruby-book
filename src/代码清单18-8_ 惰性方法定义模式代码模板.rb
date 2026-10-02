class DynamicFinder
  def method_missing(name, *args, &block)
    # 分析方法名，决定是否需要创建方法
    if name.to_s.start_with?('find_by_')
      attribute = name.to_s.sub('find_by_', '')

      # 动态创建方法
      define_method(name) do
        # 实际查找逻辑
        @records&.find { |r| r[attribute.to_sym] == args.first }
      end

      # 执行新创建的方法
      send(name, *args, &block)
    else
      super  # 不认识的调用，交给默认处理
    end
  end

  def respond_to_missing?(name, include_private = false)
    name.to_s.start_with?('find_by_') || super
  end
end