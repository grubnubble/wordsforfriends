class User < ActiveRecord::Base
  attr_accessible :active, :name, :pass, :email, :username

  validates :name, :pass, :email, :username, :presence => true 

  validates :name,
    :length => { :maximum => 256,
      :message => 'is too long' }

  validates :email,
    :format => { :with => /\A\S+@\S+\.\S+\z/,
      :message => 'must be a valid email' },
    :uniqueness => { :message => 'is taken' },
    :length => { :maximum => 384 }

  validates :username,
    :format => { :with => /\A[a-zA-Z]/, 
      :message => 'must begin with a letter' },
    :uniqueness => { :case_sensitive => false,
      :message => 'is taken' },
    :length => { :in => 3..32,
      :message => 'has to be between 3 and 32 characters' }

  has_many :writings, :dependent => :destroy
  has_many :friendships
  has_many :friends, :through => :friendships
end
