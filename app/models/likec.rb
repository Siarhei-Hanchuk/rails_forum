class Likec
  include Mongoid::Document
  field :post_id, :type => Integer
  field :count, :type => Integer

  before_create :defaults

  def defaults
  	self.count=0
  end
end

