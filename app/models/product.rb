class Product < ActiveRecord::Base
  attr_accessible :artist, :genre, :name

  validates :artist, :genre, :name, :presence => true
  validates :name, :uniqueness => {:scope => :artist}

  scope :resent, lambda{|limit| order('created_at').limit(limit)}

  DEFAULT_ORDER = "created_at desc"

  def self.delete_all_by_id(ids)
    where(['id in (?)', ids]).delete_all
  end
  
end
