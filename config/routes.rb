Autoadvisor::Application.routes.draw do
  get "pages/main"

  root :to => 'pages#main'
  devise_for :users
  resources :users
  resources :sections, :only => [:show]
  resources :majors, :only => [:show]
  match '/user/transcript/add/(:id)' => 'uploads#add_credit', :via => :get, :as => 'add_credit'
  match '/user/transcript/delete/(:id)' => 'uploads#delete_credit', :via => :get, :as => 'delete_credit'
  match '/user/transcript/upload/(:id)' => 'uploads#upload_credits', :via => :post, :as => 'upload_credits'
  match '/user/transcript/' => 'users#transcript', :via => :get, :as => 'transcript'
  match '/user/(:id)' => 'users#show', :via => :get

  match '/schedule/create/' => 'schedules#create', :via => :post, :as => 'create_schedule'
  match '/schedule/update/(:id)' => 'schedules#update', :via => :post, :as => 'update_schedule'
  match '/schedule/get/(:id)' => 'schedules#get', :via => :post, :as => 'get_schedule'
  match '/schedule/destroy/(:id)' => 'schedules#destroy', :via => :post, :as => 'destroy_schedule'
  match '/schedule/list/(:id)' => 'schedules#list', :via => :post, :as => 'list_schedule'

  match '/schedule/get_recommendations' => 'schedules#recommend', :via => :post
  match '/schedule/search' => 'schedules#search', :via => :post
  match '/schedule/recommend' => 'schedules#advisor', :via => :get
  match '/schedule/generate' => 'schedules#generate_json_schedule', :via => :post
  match '/schedule' => 'schedules#schedule', :via => :get, :as => 'schedule'
  match '/advisor' => 'schedules#advisor'
  match '/about' => 'pages#about'
  match '/documentation' => 'pages#documentation'
  match '/logged_in' => 'pages#logged_in', :via => [:get, :post] if Rails.env.development?

  # /app/views/pages/transcript.html.erb [not yet created]
  #get '/transcript', to: 'pages#transcript'
  # /app/views/pages/friends.html.erb [not yet created]

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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
