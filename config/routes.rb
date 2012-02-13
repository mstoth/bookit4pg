Bookit4pg::Application.routes.draw do

  get 'admins/allusers'
  get 'admins/index'
  get 'admins/groups'
  get 'admins/error'
  get 'admins/venues'
  get 'admins/concerts'
  
  resources :venues
  
  get "groups/join"
  resources :groups

  resources :concerts
  
  get "concerts/venues_near"
  get "venues/concerts_near"
  
  match "users/join_venue/:id" => "users#join_venue", :as => :join_venue
  match "users/leave_venue/:id" => "users#leave_venue", :as => :leave_venue
  match "users/join_group/:id" => "users#join_group", :as => :join_group
  match 'concerts_near_me' => "concerts#near_venue", :as => :concerts_near_me
  match "concerts/:id/near_venue" => "concerts#near_venue", :as => :near_venue
  match "concerts/:id/venues_near" => "concerts#venues_near", :as => :venues_near
  match "venues/:id/concerts_near" => "venues#concerts_near", :as => :concerts_near
  match "agent/:id/help" => "agent#help", :as => :help

  match 'about' => "agent#about", :as => :about
  match 'help' => "agent#help", :as => :help
  match 'search' => "agent#search", :as => :search
  match 'home' => "agent#home", :as => :home

  get "agent/error"
  get "agent/home"
  get "agent/about"
  get "agent/search"
  get "agent/help"
  get "agent/contact"

  post "admins/delete_user"
  
  get "user_sessions/new"

  resource :account, :controller => "users"

  resources :users

  resources :user_sessions

  match 'login' => "user_sessions#new", :as => :login

  match 'logout' => "user_sessions#destroy", :as => :logout

  match 'contact' => "agent#contact", :as => :contact

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => "agent#home"
  
  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
