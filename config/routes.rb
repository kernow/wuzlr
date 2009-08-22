ActionController::Routing::Routes.draw do |map|
  map.resources :leagues


  map.root :controller => 'home'
  
  map.resources :leagues, :except => [:index, :destroy] do |l|
    l.resources :matches, :member => {:play => :get}, :except => [:index, :destroy]
  end
  
end
