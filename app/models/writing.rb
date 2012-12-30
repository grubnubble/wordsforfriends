class Writing < ActiveRecord::Base
  attr_accessible :author_id, :body, :friends_r, :global_r, :title

  validates :author_id, :body, :friends_r, :global_r, :presence => true
end
