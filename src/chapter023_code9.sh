# 方式1: 直接运行
ruby todo_cli.rb list
ruby todo_cli.rb add "买牛奶"
ruby todo_cli.rb add "整理文件"
ruby todo_cli.rb list
ruby todo_cli.rb complete 1
ruby todo_cli.rb list
ruby todo_cli.rb delete 2
ruby todo_cli.rb help

# 方式2: 添加执行权限后直接运行（Unix系统）
chmod +x todo_cli.rb
./todo_cli.rb list