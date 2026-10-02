class User
  def initialize(data)
    @data = data
  end

  def method_missing(name, *args)
    # 把方法名转换成字符串
    key = name.to_s

    if key.end_with?('=')
      # 赋值操作：user.name = 'Alice'
      attr = key[0...-1]  # 去掉等号得到属性名
      @data[attr] = args.first
    else
      # 读取操作：user.name
      @data[key]
    end
  end
end

user = User.new({})
user.name = 'Alice'        # 调用 method_missing
user.age = 30             # 调用 method_missing
puts user.name            # 调用 method_missing => "Alice"
puts user.age             # 调用 method_missing => 30
puts user.email           # 调用 method_missing => nil（不报错）