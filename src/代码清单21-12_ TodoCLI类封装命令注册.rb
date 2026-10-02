class TodoCLI
  def initialize
    @commands = {}
  end

  def register(name, handler)
    @commands[name] = handler
  end

  def run(args)
    command = args[0] || "help"
    if @commands[command]
      @commands[command].call(args[1..-1])
    else
      puts "可用命令: #{@commands.keys.join(', ')}"
    end
  end
end

cli = TodoCLI.new
cli.register("add")    { |args| puts "添加: #{args[0]}" }
cli.register("list")   { |args| puts "列出所有任务" }
cli.register("done")   { |args| puts "完成: #{args[0]}" }

cli.run(ARGV)