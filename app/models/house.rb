class House < ActiveRecord::Base
	has_attached_file :image, default_url: "missing.png"
	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

	has_many :orders
	belongs_to :user

	geocoded_by :address
	before_validation :geocode

	validate :latitude, presence: true
	validate :longitude, presence: true

end
