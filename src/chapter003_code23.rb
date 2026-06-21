timestamp = "2024-01-15"
level = "INFO"
message = "User logged in"

log_entry = "[#{timestamp}] #{level.upcase.ljust(5)} - #{message}"

puts log_entry
# 输出：[2024-01-15] INFO   - User logged in