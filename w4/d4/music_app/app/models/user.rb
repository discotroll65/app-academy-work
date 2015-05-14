class User < ActiveRecord::Base
  attr_reader :password

  validates :email, :session_token, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :password, length: {minimum: 6, allow_nil: true}

  after_initialize :ensure_session_token

  def self.find_by_credentials(given_email, given_password)
    user = User.find_by(email: given_email)
    return nil unless user
    user.is_password?(given_password) ? user : nil
  end

  def ensure_session_token
    self.session_token ||= SecureRandom::urlsafe_base64
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end


  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

end
