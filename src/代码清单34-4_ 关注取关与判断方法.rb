def follow(user)
  return false if user.nil? || user.id == id
  return false if following?(user)
  
  ActiveRecord::Base.transaction do
    active_follows.create!(followed_id: user.id)
  end
  true
rescue ActiveRecord::RecordNotUnique
  false
end

def unfollow(user)
  return false if user.nil?
  active_follows.find_by(followed_id: user.id)&.destroy
  true
end

def following?(user)
  return false if user.nil?
  active_follows.exists?(followed_id: user.id)
end