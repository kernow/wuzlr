ActionController::Routing::Routes.draw do |map|

  map.root :controller => 'home'
  
  map.resources :leagues, :except => [:index, :destroy] do |league|
    league.resources :invites, :only   => [:new, :create]
    league.resources :matches, :except => [:index, :destroy]
  end
  
  map.resources :users, :only => [:new, :create] do |user|
    user.resources :leagues, :only => :index
  end
end
