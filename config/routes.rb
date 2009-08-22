ActionController::Routing::Routes.draw do |map|
  map.resources :leagues

  map.resources :users
  
  map.account "/account", :controller => 'users', :action => 'account'
  
  map.root :controller => 'home'
  
  map.resources :leagues, :except => [:index, :destroy] do |l|
    l.resources :matches, :except => [:index, :destroy]
  end
  
end
