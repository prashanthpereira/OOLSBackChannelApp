class User < ActiveRecord::Base
  has_many :votes
  has_many :posts
  attr_accessible :password, :username, :role, :password_confirmation, :name
  validates :name, :presence => true
  validates :username, :presence => true
  validates :role, :presence => true
  validates :password, presence: true, :confirmation =>true, :on => :create
  validates :password_confirmation, :presence => true, :on => :create

  validates_confirmation_of :password
  validates_uniqueness_of :username

  def authenticate password
    if self.password == password
      true
    else
      false
    end
  end

  def admin?
    if self.role == 'admin'
      true
    else
      false
    end
  end

  def current_user? username
    if self.username == username
       true
    else
      false
    end
  end
end
