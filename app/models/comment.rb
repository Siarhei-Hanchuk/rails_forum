class Comment < ActiveRecord::Base
	attr_accessible :body, :post_id, :user_id, :created_at
	belongs_to :post
	belongs_to :user

	validates :body, :length => {:minimum=>1, maximum: 255}
end
