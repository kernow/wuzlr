class Match < ActiveRecord::Base
  
  belongs_to :league
  
  has_many :match_players
  
  has_many :players,      :through => :match_players
  has_many :red_players,  :through => :match_players, :conditions => 'match_players.team = "red"' , :source => :player
  has_many :blue_players, :through => :match_players, :conditions => 'match_players.team = "blue"', :source => :player
  
  validates_presence_of :league
  validates_inclusion_of :red_score,  :in => 0..10
  validates_inclusion_of :blue_score, :in => 0..10
  validate :scores
  
  def winner
    if red_score > blue_score
      "red"
    else
      "blue"
    end
  end
  
  def looser
    if red_score < blue_score
      "red"
    else
      "blue"
    end
  end
  
  def winners
    case winner
    when "red" : red_players
    when "blue": blue_players
    else nil
    end
  end
  
  def loosers
    case looser
    when "red" : red_players
    when "blue": blue_players
    else nil
    end
  end
  
private
  
  def scores
    unless (red_score == 10) ^ (blue_score == 10)
      errors.add_to_base "One team only must score 10"
    end
  end
    
end
