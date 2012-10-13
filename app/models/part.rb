class Part < ActiveRecord::Base
	attr_accessible :desc, :title
	has_many :topics
	validates :title, :presence => true, :length => { :minimum => 5, :maximum => 40}
	validates :desc, :presence => true
end
