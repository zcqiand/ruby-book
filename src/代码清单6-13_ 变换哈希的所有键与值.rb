h = { a: 1, b: 2, c: 3 }

# transform_keys：变换所有键（键变字符串，值不变）
h.transform_keys(&:to_s)  # => { 'a'=>1, 'b'=>2, 'c'=>3 }

# transform_values：变换所有值（值乘10，键不变）
h.transform_values { |v| v * 10 }  # => { a: 10, b: 20, c: 30 }