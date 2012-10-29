Forum3::Application.routes.draw do

  resources :posts

  resources :parts

  post '/topics/create'
  resources :topics

  get '/users/sing_out' => 'users#sing_out'
  get '/users/change_role' => 'users#change_role'
  resources :users

  controller :search do
    post 'search/index' => :index
  end

  controller :ajax do
    get '/ajax/like' => :like
    get '/ajax/like_logins' =>  :like_logins
    post '/ajax/comment' => :comment
  end

  #post '/user/change_password' => 'users#change_password'

  #namespace :admin do
  #  get '', to: 'dashboard#index', as: '/'
  #end

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
  root :to => 'parts#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  Forum3::Application.routes.draw do
    devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
    resources :users, :only => [:index, :destroy]
    root :to => 'users#index'
  end

end
