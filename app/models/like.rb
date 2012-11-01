class Like
  include Mongoid::Document
  field :user_id, :type => Integer
  field :post_id, :type => Integer
end

