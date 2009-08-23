class HomeController < ApplicationController
  
  layout "home"
  
  def index
    
    @leagues = League.find(:all, :limit => 3, :order => "created_at DESC")
    @users = User.find(:all, :limit => 12, :order => "created_at DESC")
    @dedicated = User.find(:all, :limit => 12, :order => "played DESC")
  end
  
end
