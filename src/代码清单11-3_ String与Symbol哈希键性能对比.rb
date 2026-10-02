# String 做键：每次 "status" 都是不同对象，Ruby 要逐字符比较
string_hash = {}
100_000.times { string_hash["status"] = 1 }  # 慢

# Symbol 做键：所有 :status 共享同一对象，一次整数比较即定位
symbol_hash = {}
100_000.times { symbol_hash[:status] = 1 }   # 快 5-10 倍