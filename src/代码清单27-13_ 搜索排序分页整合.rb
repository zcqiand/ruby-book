# 完整搜索+排序+分页
def search_with_pagination(criteria: {}, sort_by: :name, order: :asc, page: 1, page_size: 20)
  # 先搜索和排序
  success, results = search_and_sort(criteria: criteria, sort_by: sort_by, order: order)
  return [false, results] unless success

  # 再分页
  paginated = paginate(results, page: page, page_size: page_size)

  [true, paginated]
end