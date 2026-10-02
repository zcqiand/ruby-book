msg = "Ruby 是动态语言，Ruby 很灵活"
puts msg.sub("Ruby", "Python")
puts msg.gsub("Ruby", "Python")
phone = "电话：138-1234-5678"
puts phone.gsub(/\d{3}-\d{4}-\d{4}/, '***-****-****')
# 预期输出：
# Python 是动态语言，Ruby 很灵活
# Python 是动态语言，Python 很灵活
# 电话：***-****-****