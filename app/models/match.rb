class Match < ActiveRecord::Base
  
  belongs_to :league
  
  has_many :match_players
  
  has_many :players,      :through => :match_players
  has_many :red_players,  :through => :match_players, :conditions => 'match_players.team = "red"' , :source => :player
  has_many :blue_players, :through => :match_players, :conditions => 'match_players.team = "blue"', :source => :player
  
  has_many :stats, :class_name => "MatchStat"
  
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
      validates_presence_of :started_at
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
    
    before_transition :planning => :playing do |match, transition|
      match.started_at = Time.now unless match.started_at
    end
    
    after_transition :finished => :recorded do |match, transition|
      match.winners.each {|w| 
        w.add_win  match
        match.stats.create(:user_id => w, :won => true,  :by => match.score_difference )
        match.league.add_win(w,match.finished_at)
      }
      match.losers.each {|w|
        w.add_lost match
        match.stats.create(:user_id => w, :won => false, :by => match.score_difference )
        match.league.add_lost(w,match.finished_at)
      }
    end
        
  end
  
  def winner
    if red_score > blue_score
      "red"
    elsif blue_score > red_score
      "blue"
    else
      nil
    end
  end
  
  def loser
    case winner
    when "red"  : "blue"
    when "blue" : "red"
    else nil
    end
  end
  
  def loser_score
    score_for(loser)
  end
  
  def score_difference
    (red_score - blue_score).abs
  end
  
  def winners
    case winner
    when "red" : red_players
    when "blue": blue_players
    else nil
    end
  end
  
  def losers
    case loser
    when "red" : red_players
    when "blue": blue_players
    else nil
    end
  end
  
  def duration
    Time.at(finished_at - started_at)
  end
  
  def team_with(user)
    if red_players.include? user
      "red"
    elsif blue_players.include? user
      "blue"
    else
      nil
    end
  end
  
  def team_without(user)
    case team_with(user)
    when "red"  : "blue"
    when "blue" : "red"
    else nil
    end
  end
  
  def players_for(team)
    case team
    when "red"  : red_players
    when "blue" : blue_players
    else nil
    end
  end
  
  def score_for(team)
    case team
    when "red"  : red_score
    when "blue" : blue_score
    else nil
    end
  end
  
private

  def players_on_both_sides
    errors.add_to_base "Need at least one blue player" if blue_players.empty?
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
