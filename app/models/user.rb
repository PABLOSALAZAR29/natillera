class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }
  belongs_to :persona, optional: true

  enum :rol, { usuario: 0, admin: 1 }

  validates :persona, presence: true, unless: :admin?
  validates :password, length: { minimum: 8 }, allow_nil: true
end
