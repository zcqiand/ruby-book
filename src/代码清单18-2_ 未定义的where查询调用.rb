User.where(name: 'Alice')
User.where(status: 'active').order(created_at: :desc)