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
  
  def table_bias
    red_score  = Array.new(10){|i| "Won by #{i+1}"}.map{|e| [e,0]}
    blue_score = Array.new(10){|i| "Won by #{i+1}"}.map{|e| [e,0]}
    
    matches.find(:all, :conditions => {:state => "recorded"}).each{|r|
      case r.winner
      when "blue"
        blue_score[r.score_difference - 1][1] += 1
      when "red"
        red_score[r.score_difference - 1][1] += 1
      end
    }
    [red_score, blue_score]
  end
  
  
end
