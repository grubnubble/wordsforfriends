class User < ActiveRecord::Base
  attr_accessible :boolean, :name, :pass, :string, :username
end
