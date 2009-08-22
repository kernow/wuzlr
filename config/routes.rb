ActionController::Routing::Routes.draw do |map|
  map.resources :leagues


  map.root :controller => 'home'
  
  map.resources :leagues, :except => [:index, :destroy]
  
end
