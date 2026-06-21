# frozen_string_literal: true

# 为 follows 表添加 counter_cache 字段
# counter_cache 通过计数缓存避免频繁 COUNT 查询，提升列表页性能
class AddCounterCacheToFollows < ActiveRecord::Migration[7.2]
  def change
    # 在 users 表添加关注数和粉丝数字段
    # 使用 integer 类型，默认为 0
    add_column :users, :following_count, :integer, default: 0, null: false
    add_column :users, :followers_count, :integer, default: 0, null: false

    # 为计数字段添加索引，支持按粉丝数排序的用户发现功能
    add_index :users, :followers_count

    # 初始化现有用户的计数值
    # 使用 UPDATE 而非循环，避免 N+1
    execute <<~SQL.squish
      UPDATE users
      SET following_count = (
        SELECT COUNT(*) FROM follows WHERE follower_id = users.id
      ),
      followers_count = (
        SELECT COUNT(*) FROM follows WHERE followed_id = users.id
      )
    SQL
  end
end
