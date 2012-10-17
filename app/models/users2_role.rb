class Users2Role < ActiveRecord::Base
  belongs_to :user
  attr_accessible :role
end
