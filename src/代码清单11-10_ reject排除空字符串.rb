# 排除空字符串
names = ["Alice", "", "Bob", "", "Carol"]
names.reject(&:empty?)             # => ["Alice", "Bob", "Carol"]