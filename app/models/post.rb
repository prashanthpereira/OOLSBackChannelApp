class Post < ActiveRecord::Base
  belongs_to :parent, :class_name => 'Post', :foreign_key => "parent_id"
  belongs_to :user
  belongs_to :category
  has_many :votes
  has_many :posts
  attr_accessible :content, :parent_id, :user_id, :category_id, :created_at, :updated_at
  validates :content, :presence => true
  validates :user_id, :presence => true
  validates :category_id, :presence => true
end

