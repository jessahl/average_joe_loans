class Lender < ActiveRecord::Base
  has_secure_password
  has_many :borrowers, through: :transaction
  has_many :transactions

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :first_name, :last_name, :balance, presence: true
  validates :password, length: {minimum:8}, :on => :create
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }
    
  before_save :email_lowercase
  
  def email_lowercase
    email.downcase!
  end
end
