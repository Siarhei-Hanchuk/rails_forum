class Post < ActiveRecord::Base
	attr_accessible :body, :topic_id, :user_id, :created_at, :updated_at

	belongs_to :user
	belongs_to :topic
	has_many :likes
	has_many :comments

	validates :body, :topic_id, :user_id, :presence => true
	validates :body, :length=> {:maximum => 250}

end
