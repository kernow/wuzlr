class User < ActiveRecord::Base
  
  include Clearance::User
  
  has_many :league_players, :foreign_key => "player_id"
  has_many :leagues, :through => :league_players
  
  has_many :match_players, :foreign_key => "player_id"
  has_many :matches, :through => :match_players
  
  has_many :stats, :class_name => "UserStat"
  has_many :match_stats
  has_many :league_stats
    
  validates_presence_of :name
  attr_accessible :name
    
  def win_p
    if played > 0
      ((won / played.to_f) * 100).to_i
    else
      0
    end
  end
  
  def lose_p
    if played > 0
      ((lost / played.to_f) * 100).to_i
    else
      0
    end
  end
  
  def add_win(time = Time.now)
    increment :played
    increment :won
    
    calculate_win_loss_percentage
    
    self.last_won_at    = time
    self.last_played_at = time
    
    current_streak = winning_streak
    self.longest_winning_streak = current_streak if current_streak > longest_winning_streak
    self.save!
  end
  
  def add_lost(time = Time.now)
    increment :played
    increment :lost
    
    calculate_win_loss_percentage
    
    self.last_lost_at   = time
    self.last_played_at = time
    
    current_streak = losing_streak
    self.longest_losing_streak = current_streak if current_streak > longest_losing_streak
    self.save!
  end
  
  def winning_streak
    if last_played_at == last_won_at
      matches_since last_lost_at
    else
      0
    end
  end
  
  def losing_streak
    if last_played_at == last_lost_at
      matches_since last_won_at
    else
      0
    end
  end
  
  def time_playing
    time = 0
    matches.collect {|m| time = time + m.duration_in_seconds }
    time
  end
  
  def calculate_win_loss_percentage
    self.win_loss_percentage = (won / (won.to_f + lost.to_f)) * 100
  end
  
  def win_loss_percentage_i
    win_loss_percentage.to_i
  end
  
  def self.wup_wup_playaz # AKA the players with the best win/loss percentage
    User.find :all, :limit => 5, :order => "win_loss_percentage DESC"
  end
  
private
  
  def matches_since(time)
    matches.find(:all, :conditions => "finished_at > '#{time}'").size
  end
  
end
