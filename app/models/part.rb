class Part < ActiveRecord::Base
	before_create :default_values
	attr_accessible :desc, :title, :sort
	has_many :topics
	validates :title, :presence => true, :length => { :minimum => 5, :maximum => 40}
	validates :desc, :presence => true
	#validates :sort, :presence => true

	def default_values
		self.sort ||= 0
	end
end
