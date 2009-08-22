class League < ActiveRecord::Base
  
  validates_presence_of :name
  
  has_many :matches
  
  has_many :league_players
  has_many :players, :through => :league_players
  
end
