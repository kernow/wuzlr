ActionController::Routing::Routes.draw do |map|

  map.resources :users
  
  map.account "/account", :controller => 'users', :action => 'account'
  
  map.root :controller => 'home'
  
  map.resources :leagues, :except => [:index, :destroy] do |league|
    league.resources :invites, :only   => [:new, :create]
    league.resources :matches, :except => [:index, :destroy], :member => {:full_time => :put}
  end
  
end
