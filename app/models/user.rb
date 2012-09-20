class User < ActiveRecord::Base
  has_many :votes
  has_many :posts
  attr_accessible :password, :username, :role, :password_confirmation, :name

  #validation
  validates :name, :presence => true
  validates :username, :presence => true
  validates :role, :presence => true
  validates :password, presence: true, :confirmation =>true, :on => :create
  validates :password_confirmation, :presence => true, :on => :create

  #validate the password and confirm password fields
  validates_confirmation_of :password
  #validate the username is unique
  validates_uniqueness_of :username

  #authenticate the correct password was entered
  def authenticate password
    if self.password == password
      true
    else
      false
    end
  end

  #return true if admin
  def admin?
    if self.role == 'admin'
      true
    else
      false
    end
  end

  #return true if username is current user's username
  def current_user? username
    if self.username == username
       true
    else
      false
    end
  end
end
