class Topic < ActiveRecord::Base
	attr_accessible :part_id, :title, :user_id
	belongs_to :user
	belongs_to :part
	has_many :posts

	validates :title, :part_id, :user_id, :presence => true
	validates :title, :length=> {:minimum=>3}
end
