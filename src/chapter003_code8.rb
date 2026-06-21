puts "第一行\n第二行"
puts "列1\t列2"
puts "他说：\"你好\""
puts "路径：C:\\Users\\Admin"
raw = %q[第一行\n第二行]
puts raw
# 预期输出：
# 第一行
# 第二行
# 列1	列2
# 他说："你好"
# 路径：C:\Users\Admin
# 第一行\n第二行（%q[] 不解释转义，\n 为字面量）