class HomeController < ApplicationController
  
  layout "home"
  
  def index
    @leagues = LeagueStat.most_active_leagues
    @users = User.find(:all, :limit => 15, :order => "created_at DESC")
    @dedicated = User.find(:all, :limit => 3, :order => "played DESC")
  end
  
end
