class User < ApplicationRecord
  attr_reader :password

  after_initialize :ensure_session_token

  validates :email, :password_digest, :session_token, presence: true
  validates :password, length: {minimum: 6, allow_nil: true}
  validates :email, :session_token, uniqueness: true

  has_many :subs,
    class_name: "Sub",
    foreign_key: :user_id,
    primary_key: :id,
    inverse_of: :moderator

  has_many :posts, inverse_of: :author

  has_many :comments, inverse_of: :author

  def self.find_by_credentials(username, password)
    user = User.find_by(email: username)
    user.try(:is_password?, password) ? user : nil
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def self.generate_session_token
    SecureRandom.urlsafe_base64(16)
  end

  def reset_session_token
    self.session_token = SecureRandom.urlsafe_base64(16)
    self.save!
    self.session_token
  end

  private
  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64(16)
  end
end
