result = "2024-01-15".match(/(?<year>\d{4})-(?<month>\d{2})-(?<day>\d{2})/)
result[:year]   # => "2024"
result[:month]  # => "01"
result[:day]    # => "15"