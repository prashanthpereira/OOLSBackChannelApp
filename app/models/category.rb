class Category < ActiveRecord::Base
  has_many :posts
  #associate to users through posts
  has_many :users, :through => :posts
  #associate to votes through posts
  has_many :votes, :through => :posts
  attr_accessible :name

  #validation
  validates :name, :presence => true
end
