# 查找所有gmail用户，按姓名升序排列
success, results = manager.search_and_sort(
  criteria: { email: 'gmail' },
  sort_by: :name,
  order: :asc
)

# 查找所有联系人，按添加时间倒序（最新的在前）
success, results = manager.search_and_sort(
  criteria: {},
  sort_by: :created_at,
  order: :desc
)