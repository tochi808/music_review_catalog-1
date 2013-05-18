class Product < ActiveRecord::Base
  DEFAULT_ORDER = "created_at DESC"

  attr_accessible :genre, :name, :artist_id

  belongs_to :artist
  has_many :reviews, :dependent => :destroy
  validates :genre, :name, :presence => true
  validates :name, :uniqueness => {:scope => :artist_id}


  self.per_page = 5


  scope :resent, lambda{|limit| order('created_at DESC').limit(limit)}

  def self.delete_all_by_id(ids)
    where(['id in (?)', ids]).delete_all
  end
  
end
