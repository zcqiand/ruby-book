# || 短路求值提供默认值
database_url = nil
url = database_url || "postgres://localhost:5432/mydb"
puts "默认值赋值结果 = #{url}"              # => postgres://localhost:5432/mydb