gem install ./hello_gem-0.1.0.gem
# 成功输出：
#   Successfully installed hello_gem-0.1.0
#   Parsing documentation for hello_gem-0.1.0
#   Installing ri documentation for hello_gem-0.1.0
#   1 gem installed

# 测试 Gem 功能
ruby -r hello_gem -e "puts HelloGem.greet('World')"
# 输出：Hello, World!

# 测试多语言
ruby -r hello_gem -e "puts HelloGem.greet('Ruby', language: :zh)"
# 输出：你好, Ruby!