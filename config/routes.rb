ActionController::Routing::Routes.draw do |map|

  map.resources :users
  
  map.account "/account", :controller => 'users', :action => 'account'
  
  map.root :controller => 'home'
  
  map.resources :leagues, :except => [:index, :destroy] do |league|
    league.resources :invites, :only   => [:new, :create]
    league.resources :matches, :except => [:index, :destroy], :member => {:full_time => :put}
  end
  
<<<<<<< HEAD:config/routes.rb
=======
  map.resources :users, :only => [:new, :create] do |user|
    user.resources :leagues, :only => :index
  end
>>>>>>> c6bbbb2c7a91d563d7a59021e93fd433d0d3c0e7:config/routes.rb
end
