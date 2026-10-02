module M
  def identifier
    "M"
  end
end

class Example
  include M  # 插入到实例方法查找链
end

class ExampleWithExtend
  extend M  # 将模块方法提升为类方法
end

class ExampleWithPrepend
  prepend M  # 插入到方法查找链最前面，覆盖类的方法

  def identifier
    "ExampleWithPrepend"
  end
end

puts "=== Mixin 三剑客方法查找链对比 ==="
puts "\n1. include — 混入实例方法："
ex = Example.new
puts "   Example.new.identifier: #{ex.identifier}"
puts "   Example.ancestors: #{Example.ancestors.take(3).inspect}"

puts "\n2. extend — 混入类方法："
puts "   ExampleWithExtend.identifier: #{ExampleWithExtend.identifier}"
puts "   ExampleWithExtend.new.identifier: #{ExampleWithExtend.new.identifier rescue 'NoMethodError'}"

puts "\n3. prepend — 插入方法查找链前端："
ex_p = ExampleWithPrepend.new
puts "   ExampleWithPrepend.new.identifier: #{ex_p.identifier}"
puts "   ExampleWithPrepend.ancestors: #{ExampleWithPrepend.ancestors.take(3).inspect}"