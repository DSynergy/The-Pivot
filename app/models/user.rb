class User < ActiveRecord::Base
  before_validation :format_credit_card
  validates :username, presence: true
  validates :email_address, presence: true, uniqueness: true
  validates :display_name, length: { in: 2..32 }, allow_blank: true
  validates_format_of :email_address, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/, on: :create
  validates_format_of :credit_card, with: /\d{15,16}/, on: :create, allow_blank: true

  has_many :listings
  has_many :bookings
  has_secure_password

  enum role: %w(active admin inactive)

  def format_credit_card
    if credit_card
      credit_card.gsub!(/\D/,'')
    end
  end

end



# # \b(?<![\$\&\+\_\--\/\<\>\?])(?:(?:(?:4\d|5[1-5]|65)(\d\d)(?!\1{3})
# |35(?:2[89]|[3-8]\d)|6(?:011|4[4-9]\d|22(?:1(?!1\d|2[1-5])|[2-8]|9
# (?=1\d|2[1-5]))))([\ \-]?)(?<!\d\ \d{4}\ )(?!(\d)\3{3})(\d{4})\2
# (?!\4|(\d)\5{3}|1234|2345|3456|5678|7890)(\d{4})(?!\ \d{4}\ \d)\2
# (?!\6|(\d)\7{3}|1234|3456)|3[47]\d{2}([\ \-]?)(?<!\d\ \d{4}\ )
# (?!(\d)\9{5}|123456|234567|345678)\d{6}(?!\ \d{5}\ \d)\
# 8(?!(\d)\10{4}|12345|56789|67890)\d|(?:(?:5[0678]|6[27])\d\d|6304|6390)
# \d{11}(?!(\d)\11{3}))\d{4}(?![\$\&\+\_\-\/\<\>])(?![\.\?]\d)\ba-z]{2,})\z/,
