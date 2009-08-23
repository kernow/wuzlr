class UserStat < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :other_user, :class_name => "User"
  
  named_scope :opponents, :conditions => {:relation => "opponent"}
  named_scope :allies,    :conditions => {:relation => "ally"    }
  named_scope :won,       :conditions => {:won      => true      }
  named_scope :lost,      :conditions => {:won      => false     }
  
end
