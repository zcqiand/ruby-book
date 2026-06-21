class Robot
  %w[walk run fly swim].each do |action|
    define_method(action) do
      "机器人正在#{action}"
    end
  end
end

robot = Robot.new
puts robot.walk   # => "机器人正在walk"
puts robot.fly    # => "机器人正在fly"