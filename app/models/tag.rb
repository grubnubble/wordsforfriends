class Tag < ActiveRecord::Base
  attr_accessible :name

  validates :name,
    :presence => true,
    :length => { :in => 2..64,
      :message => 'must be between 2 and 64 characters' }

  has_and_belongs_to_many :writings, :join_table => 'writingtagjoin' 
end
