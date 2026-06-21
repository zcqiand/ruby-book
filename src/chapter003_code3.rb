# 单引号：原样输出，不解释转义和插值
single_quoted = 'Hello\nWorld'
puts single_quoted
# 输出：Hello\nWorld（字面量）

# 双引号：解释转义序列和插值
double_quoted = "Hello\nWorld"
puts double_quoted
# 输出：
# Hello
# World