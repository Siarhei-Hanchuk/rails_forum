class Like < ActiveRecord::Base
  attr_accessible :user_id, :post_id
  belongs_to :post
  has_many :users
end
