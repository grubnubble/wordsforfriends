class Writing < ActiveRecord::Base
  attr_accessible :author_id, :body, :friends_r, :global_r, :title

  validates :title, :body, :presence => true

  belongs_to :user, :foreign_key => 'author_id'
  has_and_belongs_to_many :tags, :join_table => 'writingtagjoin'

  scope :for_strangers, where(:global_r => true)
  scope :for_friends, where(:friends_r => true)
  scope :by_friends, lambda { 
    |friends| where( "author_id in (?)", 
      ( friends.empty? ? '' : friends.pluck(:id))) 
  }
  scope :by_strangers, lambda { 
    |friends| where( "author_id not in (?)", 
      ( friends.empty? ? '' : friends.pluck(:id))) 
  }

  def self.privy( user)
    if user
      Writing.where( 
        'author_id in (:friends) and friends_r = "t"' +
        ' or author_id not in (:friends) and global_r = "t"', 
        { :friends => ( user.friends.empty? ? '' : user.friends.pluck(:id)) })
    else
      Writing.for_strangers
    end
  end
end
