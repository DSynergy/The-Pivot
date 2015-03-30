class User < ActiveRecord::Base
  validates :username, presence: true
  validates :email_address, presence: true, uniqueness: true
  validates :display_name, length: { in: 2..32 }, allow_blank: true
  validates_format_of :email_address, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/, on: :create

  has_many :orders
  has_secure_password

  enum role: %w(default admin)
end
