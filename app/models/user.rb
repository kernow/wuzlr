class User < ActiveRecord::Base
  
  include Clearance::User
  
  has_many :league_players, :foreign_key => "player_id"
  has_many :leagues, :through => :league_players
  
  has_many :match_players, :foreign_key => "player_id"
  has_many :matches, :through => :match_players
  
end
