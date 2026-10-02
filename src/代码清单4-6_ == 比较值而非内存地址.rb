puts "5 == 5 = #{5 == 5}"               # => true
puts "5 == 5.0 = #{5 == 5.0}"           # => true（值相等，自动类型转换）
puts "'hello' == 'hello' = #{'hello' == 'hello'}"  # => true
puts "'hello'.object_id == 'hello'.object_id = #{'hello'.object_id == 'hello'.object_id}"  # => false（对象不同）