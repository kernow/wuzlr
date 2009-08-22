class League < ActiveRecord::Base
  
  validates_presence_of :name
  validates_presence_of :user, :on => :create
  
  belongs_to :user
  has_many :matches
  
  has_many :league_players
  has_many :players, :through => :league_players
  
  def add_player(user)
    league_players.create(:player_id => user.id) unless players.include?(user)
  end
  
  def owner?(user)
    self.user == user
  end
  
  def member_of?(user)
    self.players.include?(user)
  end
end
