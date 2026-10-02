def display_result(value, format: "number", decimals: 2)
  formatted = case format
              when "number" then value.round(decimals)
              when "chinese" then "#{value.round(decimals)} 元"
              when "percent" then "#{(value * 100).round(decimals)}%"
              else value
              end
  puts formatted
end

display_result(3.14159)                        # 输出: 3.14
display_result(3.14159, format: "chinese")    # 输出: 3.14 元
display_result(0.8765, format: "percent", decimals: 1)  # 输出: 87.7%