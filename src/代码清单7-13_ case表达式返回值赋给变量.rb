temperature = 18
clothing = case temperature
           when 0..14 then "羽绒服"
           when 15..25 then "长袖"
           else "短袖"
           end

puts "今天建议穿：#{clothing}"