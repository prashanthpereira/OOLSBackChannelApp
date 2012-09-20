class Post < ActiveRecord::Base
  #always order posts by their updated_at in descending order
  default_scope :order => 'updated_at DESC'
  #self referencing parent post for comment; will be nil for posts
  belongs_to :parent, :class_name => 'Post', :foreign_key => "parent_id"
  belongs_to :user
  belongs_to :category
  has_many :votes
  has_many :posts
  attr_accessible :content, :parent_id, :user_id, :category_id, :created_at, :updated_at , :is_post

  #validations
  validates :content, :presence => true
  validates :user_id, :presence => true
  #category should present for posts but not for comments
  validates :category_id, :presence => true, :unless => :parent_id?
end

