class Post < ActiveRecord::Base
	attr_accessible :body, :topic_id, :user_id, :created_at, :updated_at
	belongs_to :user
	belongs_to :topic
	validates :body, :topic_id, :user_id, :presence => true
	validates :body, :length=> {:maximum => 250}

	def body=(body)
		#body.gsub!(/>/, "&gt;")
		#body.gsub!(/</, "&lt;")
		#body.gsub!(/\n/, "<br>")
		write_attribute(:body,body)
	end
end
