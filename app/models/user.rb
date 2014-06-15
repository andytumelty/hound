class User < ActiveRecord::Base
  authenticates_with_sorcery!

  validates :password, length: { minimum: 3 }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true

  validates :email, uniqueness: true

  before_create :set_auth_token

  private
    def set_auth_token
      return if auth_token.present?

      begin
        self.auth_token = SecureRandom.hex
      end while self.class.exists?(auth_token: self.auth_token)
    end
end
