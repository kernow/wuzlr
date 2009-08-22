class Match < ActiveRecord::Base
  
  belongs_to :league
  
  has_many :match_players
  
  has_many :players,      :through => :match_players
  has_many :red_players,  :through => :match_players, :conditions => 'match_players.team = "red"' , :source => :player
  has_many :blue_players, :through => :match_players, :conditions => 'match_players.team = "blue"', :source => :player
  
  validates_presence_of :league
  
  state_machine :state, :initial => :planning do
    
    event :kick_off do
      transition :planning => :playing
    end
    
    event :full_time do
      transition :playing  => :finished
    end
    
    event :record do
      transition :finished => :recorded
    end
    
    state :playing do
      validate :players_on_both_sides
      validate :players_are_unique
    end
        
    state :finished do
      validates_presence_of :finished_at
    end
    
    state :recorded do
      validates_inclusion_of :red_score,  :in => 0..10
      validates_inclusion_of :blue_score, :in => 0..10
      validate :scores
    end
    
    after_transition :finished => :recorded do |match, transition|
      match.winners.each {|w| w.add_win  }
      match.loosers.each {|w| w.add_lost }
    end
        
  end
  
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

  def players_on_both_sides
    errors.add_to_base "Need at lease one blue player" if blue_players.empty?
    errors.add_to_base "Need at least one red player"  if red_players.empty?
  end
  
  def players_are_unique
    if players != players.uniq
      (players - players.uniq).each {|p|
        errors.add_to_base "#{p.name} can only play in one position"
      }
    end
  end
  
  def scores
    unless (red_score == 10) ^ (blue_score == 10)
      errors.add_to_base "One team only must score 10"
    end
  end
    
end
