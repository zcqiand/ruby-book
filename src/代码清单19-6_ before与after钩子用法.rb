describe UserManager do
  before do
    @manager = UserManager.new
  end

  after do
    # 清理测试数据，比如删除临时文件
  end

  it '添加用户成功' do
    result = @manager.add_user('张三', 'zhangsan@example.com')
    assert result
  end

  it '添加空邮箱失败' do
    result = @manager.add_user('王五', '')
    refute result
  end
end