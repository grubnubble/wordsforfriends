class Writing < ActiveRecord::Base
  attr_accessible :author_id, :body, :friends_r, :global_r, :title

  validates :author_id, :title, :body, :presence => true

  belongs_to :user, :foreign_key => 'author_id'
  has_and_belongs_to_many :tags, :join_table => 'writingtagjoin'
end
