class Post < ActiveRecord::Base
	attr_accessible :body, :topic_id, :user_id, :created_at, :updated_at

	belongs_to :user
	belongs_to :topic
	has_many :comments, :dependent => :destroy

	validates :body, :topic_id, :user_id, :presence => true
	validates :body, :length=> {:minimum => 1, :maximum => 250}

	def body=(body)
		body.gsub! /\n/, '<br>'
		write_attribute(:body,body)
	end

	def likes
		@likes ||= Like.where(:post_id => self.id)
	end
end
