class User < ActiveRecord::Base
  attr_reader :password
  after_initialize :ensure_session_token
  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true}

  def self.find_by_credentials(email, pw)
    user = User.find_by(email: email)
    if user && user.is_password?(pw)
      user
    else
      nil
    end
  end

  def self.generate_session_token
    SecureRandom.urlsafe_base64(128)
  end

  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save
    self.session_token
  end

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end

  def password=(pw)
    @password = pw
    self.password_digest = BCrypt::Password.create(pw)
  end

  def is_password?(pw)
    BCrypt::Password.new(self.password_digest).is_password?(pw)
  end
end
