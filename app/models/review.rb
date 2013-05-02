class Review < ActiveRecord::Base
  attr_accessible :body, :product_id, :user_id

  belongs_to :product
  belongs_to :user

  validates :body, :presence => true

end
