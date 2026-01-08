# app/models/user.rb
class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true

  def as_json(options = {})
    super(
      except: [:password_digest]
    )
  end




end
