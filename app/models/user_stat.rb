class UserStat < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :other_user, :class => "User"
  
end
