class Match < ActiveRecord::Base
  
  belongs_to :league
  
  has_many :match_players
  
  has_many :players,      :through => :match_players
  has_many :red_players,  :through => :match_players, :conditions => 'match_players.team = "red"' , :source => :player
  has_many :blue_players, :through => :match_players, :conditions => 'match_players.team = "blue"', :source => :player
  
end
