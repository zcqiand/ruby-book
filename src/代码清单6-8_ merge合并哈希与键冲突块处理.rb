default = { theme: 'dark', lang: 'zh', debug: false }
user_override = { theme: 'light', debug: true }

# merge：返回新哈希，原哈希不变
merged = default.merge(user_override)
puts merged  # => {:theme=>'light', :lang=>'zh', :debug=>true}
puts default # => {:theme=>'dark', :lang=>'zh', :debug=>false}

# merge!：就地修改原哈希
default.merge!(user_override)
puts default # => {:theme=>'light', :lang=>'zh', :debug=>true}

# 带块的合并：处理键冲突
prices_a = { apple: 5, banana: 3 }
prices_b = { apple: 6, banana: 2, orange: 4 }
avg = prices_a.merge(prices_b) { |key, a, b| (a + b) / 2.0 }
# => {:apple=>5.5, :banana=>2.5, :orange=>4}