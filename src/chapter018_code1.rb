class Robot
  def method_missing(name, *args)
    puts "拦截到方法调用：#{name}，参数：#{args.inspect}"
  end
end

r = Robot.new
r.任意奇怪的方法名("参数一", "参数二")
# 输出：拦截到方法调用：任意奇怪的方法名，参数：["参数一", "参数二"]