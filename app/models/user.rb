class User < ActiveRecord::Base
	validates :username, presence: true, uniqueness: true
	validates :email, presence: true, uniqueness: true
	validates :password, presence: true, confirmation: true, length: { minimum: 8 }

	has_secure_password

	# Gives us @user.orders e.g @user.orders.new, @user.order.all
	has_many  :orders
	has_many  :houses
end
