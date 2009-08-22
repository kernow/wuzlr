class HomeController < ApplicationController
  
  def index
    flash[:notice] = "YAHOOOOO notice"
    flash[:success] = "YAHOOOOO success"
    flash[:error] = "YAHOOOOO error"
  end
  
end
