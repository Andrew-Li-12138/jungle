class User < ApplicationRecord
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }
  validates :name, presence: true
  has_secure_password

  def self.authenticate_with_credentials(email, password)
    trimmed_lowercase_email = email.strip.downcase
    User.update_all('email = lower(email)')
    user = User.find_by(email: trimmed_lowercase_email)
    if user && user.authenticate(password)
      return user
    else
      return nil
    end
  end
end
 