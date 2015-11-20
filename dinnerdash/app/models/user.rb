class User < ActiveRecord::Base
	has_many :orders
	has_secure_password
	 validates :firstname, presence: true, length: { in: 6..20 }
	 validates :lastname, presence: true, length: { in: 6..20 }
	 validates :email, presence: true, uniqueness: true
	 validates :ph, presence: true, numericality: true, uniqueness: true
	 validates :password, confirmation: true, presence: true, length: { in: 6..20 }
end
