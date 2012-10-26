class Like < ActiveRecord::Base
  attr_accessible :user_id, :post_id
  belongs_to :post
  has_many :users
  #validates :post_id, :numericality => {:minimum => 1}
  #validates :user_id, :numericality => {:minimum => 1}
end
