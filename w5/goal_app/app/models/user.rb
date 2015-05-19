# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  attr_reader :password

  validates :password_digest, :session_token, :username, presence: true
  validates :session_token, :username, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true}

  has_many :goals

  after_initialize :ensure_session_token

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def self.new_session_token
    SecureRandom.urlsafe_base64
  end

  def ensure_session_token
    self.session_token ||= User.new_session_token
  end

  def reset_session_token!
    self.session_token = User.new_session_token
    self.save!
    self.session_token
  end

  def self.find_by_credentials(params)
    user = User.find_by(username: params[:username])
    user && user.is_password?(params[:password]) ? user : nil
  end

end
