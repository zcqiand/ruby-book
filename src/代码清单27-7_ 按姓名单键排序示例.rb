# 按姓名升序排列（字母顺序）
sorted_by_name = @contacts.sort_by { |c| c.name }

# 按姓名降序排列
sorted_by_name_desc = @contacts.sort_by { |c| c.name }.reverse

# 按电话升序排列
sorted_by_phone = @contacts.sort_by { |c| c.phone }