# 只需找一个时比 select 更高效，找到即停止
first_adult = ages.find { |age| age >= 18 }  # => 23