ActionController::Routing::Routes.draw do |map|

  map.root :controller => 'home'
  
  map.resources :leagues, :except => [:index, :destroy] do |league|
    league.resources :invites, :only   => [:new, :create]
  end
  
  map.resource  :users, :only => [:new, :create]
end
