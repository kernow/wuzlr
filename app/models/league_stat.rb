class LeagueStat < ActiveRecord::Base
  
  belongs_to :league
  belongs_to :user
  
  validates_uniqueness_of :user_id, :scope => :league_id
  
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
  
private

  def matches_since(time)
    user.matches.count(:conditions => "finished_at > '#{time}' AND league_id = #{league.id}")
  end
  
end
