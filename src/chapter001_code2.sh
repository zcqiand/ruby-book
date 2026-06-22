# macOS
brew install rbenv ruby-build
rbenv install 3.3.4
rbenv install 3.2.6
rbenv global 3.3.4    # 全局默认版本
cd ~/project-a && rbenv local 3.2.6   # 该目录使用 3.2.6