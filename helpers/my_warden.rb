Warden::Strategies.add(:password) do
  def valid?
    params['user'] && params['user']['email'] && params['user']['password']
  end

  def authenticate!
    user = User.find_by(email: params['user']['email']).try(:authenticate, params['user']['password'])
    if user
      success!(user)
      user.sign_in_count += 1
      user.current_sign_in_at = Time.new unless user.current_sign_in_at
      user.last_sign_in_at = Time.new
      user.save
    end
    user
  end

  def my_login(user)
    success!(user)
  end
end