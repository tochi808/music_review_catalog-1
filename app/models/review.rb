class Review < ActiveRecord::Base
  attr_accessible :body, :product_id

  belongs_to :product
end
