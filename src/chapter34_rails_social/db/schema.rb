# frozen_string_literal: true

# Schema 是数据库结构的权威文档
# 由 rails db:migrate 自动生成，不要手动编辑
#
# 本文件展示 Follow 相关表的完整结构
# 配合 Chapter 33 的 posts、comments、likes 表使用

ActiveRecord::Schema[7.2].define(version: 2024_06_21_000002) do
  # 用户表（Chapter 33 已有，此处展示相关部分）
  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "username", null: false
    t.string "bio"
    t.string "avatar_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false

    # 关注功能计数器缓存（可选，优化查询）
    t.integer "following_count", default: 0, null: false
    t.integer "followers_count", default: 0, null: false

    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["followers_count"], name: "index_users_on_followers_count"
  end

  # 帖子表（Chapter 33 已有）
  create_table "posts", force: :cascade do |t|
    t.references "user", null: false, foreign_key: true
    t.text "content", null: false
    t.integer "likes_count", default: 0, null: false
    t.integer "comments_count", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false

    t.index ["user_id", "created_at"], name: "index_posts_on_user_id_and_created_at"
  end

  # 关注关系表（本章核心）
  create_table "follows", force: :cascade do |t|
    t.references "follower", null: false, foreign_key: { to_table: :users }
    t.references "followed", null: false, foreign_key: { to_table: :users }
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false

    # 唯一约束：防止同一用户重复关注
    t.index ["follower_id", "followed_id"], name: "index_follows_on_follower_id_and_followed_id", unique: true

    # 反向索引：快速查询某用户的所有粉丝
    t.index ["followed_id"], name: "index_follows_on_followed_id"
  end

  # 评论表（Chapter 33 已有）
  create_table "comments", force: :cascade do |t|
    t.references "user", null: false, foreign_key: true
    t.references "post", null: false, foreign_key: true
    t.references "parent", foreign_key: { to_table: :comments }
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false

    t.index ["post_id"], name: "index_comments_on_post_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  # 点赞表（Chapter 33 已有，polymorphic）
  create_table "likes", force: :cascade do |t|
    t.references "user", null: false, foreign_key: true
    t.references "likeable", polymorphic: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false

    t.index ["user_id", "likeable_type", "likeable_id"], name: "index_likes_on_user_id_and_likeable", unique: true
  end
end
