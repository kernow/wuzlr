class MatchStat < ActiveRecord::Base
  
  belongs_to :match
  belongs_to :user
  
  named_scope :won,        :conditions => {:won => true  }
  named_scope :lost,       :conditions => {:won => false }

end
