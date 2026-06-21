# 使用 bundle gem 创建名为 hello_gem 的 Gem
bundle gem hello_gem --test=minitest
# 输出：
#       create  hello_gem/Gemfile
#       create  hello_gem/Rakefile
#       create  hello_gem/hello_gem.gemspec
#       create  hello_gem/lib/hello_gem.rb
#       create  hello_gem/lib/hello_gem/version.rb
#       create  hello_gem/test/test_helper.rb
#       create  hello_gem/.gitignore
#       create  hello_gem/.rubocop.yml