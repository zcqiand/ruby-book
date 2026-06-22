# 拉取官方 Ruby 镜像
docker pull ruby:3.3-alpine

# 启动一个交互式容器
docker run -it --rm ruby:3.3-alpine irb

# 或在容器中运行一个 .rb 文件
docker run -it --rm -v $(pwd):/work -w /work ruby:3.3-alpine ruby hello.rb