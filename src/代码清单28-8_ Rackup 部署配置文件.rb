# config.ru — Rackup 部署配置文件
# 为什么要用 config.ru：实现「一次编写，多种部署」——
# 本地开发用 `ruby app.rb`，生产环境用 `rackup config.ru`

# 第一步：加载应用文件
# 这里假设 app.rb 定义了 Sinatra::Application 实例
require_relative 'app'

# 第二步：声明中间件栈（与在 app.rb 中使用 use 等价）
# 推荐把中间件配置放在 config.ru 中，保持 app.rb 的纯净
require_relative 'middleware/timing_logger'
use TimingLogger

# 第三步：运行应用
# Sinatra::Application 是 Sinatra 默认的应用类
run Sinatra::Application