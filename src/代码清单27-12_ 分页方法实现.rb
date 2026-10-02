# 分页方法
def paginate(items, page: 1, page_size: 20)
  return [false, '数据不能为空'] if items.nil? || items.empty?

  page = page.to_i
  page_size = page_size.to_i
  page = 1 if page < 1
  page_size = 20 if page_size < 1

  total_items = items.size
  total_pages = (total_items.to_f / page_size).ceil

  # 计算起始和结束索引
  start_index = (page - 1) * page_size
  end_index = [start_index + page_size, total_items].min

  # 提取当前页数据
  page_items = items[start_index...end_index]

  {
    items: page_items,
    pagination: {
      current_page: page,
      page_size: page_size,
      total_items: total_items,
      total_pages: total_pages,
      has_prev: page > 1,
      has_next: page < total_pages
    }
  }
end