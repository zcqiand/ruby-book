describe Calculator do
  describe "#factorial" do
    it "返回1当输入0时" do
      assert_equal 1, Calculator.new.factorial(0)
    end

    it "正确计算5的阶乘" do
      assert_equal 120, Calculator.new.factorial(5)
    end
  end
end