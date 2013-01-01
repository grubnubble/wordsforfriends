require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt

  attr_accessible :name, :email, :username, :password, :password_confirmation
  attr_accessor :password

  before_save :encrypt_pass

  validates :name, :email, :username, :presence => true 

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

  validates_confirmation_of :password,
    :message => 'should match confirmation'

  has_many :writings, :dependent => :destroy
  has_many :friendships
  has_many :friends, :through => :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user

  def encrypt_pass
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.pass = BCrypt::Engine.hash_secret( password, password_salt)
    end
  end

  def self.authenticate( email, password)
    user = find_by_email(email)
    if user && user.pass == BCrypt::Engine.hash_secret( password, user.password_salt)
      user
    else
      nil
    end
  end
end
