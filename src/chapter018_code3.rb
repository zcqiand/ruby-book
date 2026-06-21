class 你的类名
  def method_missing(method_name, *args, &block)
    # method_name 是被调用的方法名（符号）
    # *args 是所有参数
    # &block 是代码块（如果有的话）
    # 在这里决定如何响应这个不存在的方法调用
  end
end