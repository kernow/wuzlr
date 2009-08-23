ActionController::Routing::Routes.draw do |map|

  map.resources :users
  
  map.resource  :session, :only => [:new, :create, :destroy]
  map.account "/account", :controller => 'users', :action => 'account'
  
  map.root :controller => 'home'
  
  map.resources :leagues, :except => [:index, :destroy] do |league|
    league.resources :invites, :only   => [:new, :create]
    league.resources :matches, :except => [:index, :destroy], :member => {:full_time => :put}
  end
  
  map.resources :users, :only => [:new, :create], :member => {:compare => :get} do |user|
    user.resources :leagues, :only => :index
  end
  
  map.league_graphs "/leagues/:league_id/graphs/:action", :controller => :graphs
  map.user_graphs   "/users/:user_id/graphs/:action",   :controller => :graphs
  
  map.sign_up  'sign_up',
    :controller => 'users',
    :action     => 'new'
end
