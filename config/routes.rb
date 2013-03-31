Autoadvisor::Application.routes.draw do
  get "pages/main"

  root :to => 'pages#main'
  devise_for :users
  resources :sections, :majors

  # beta used only
  # /app/views/pages/profile.html.erb
  get '/profile', to: 'pages#profile'
  # /app/views/pages/schedule.html.erb [not yet created]
  get '/schedule', to: 'pages#schedule'
  # /app/views/pages/transcript.html.erb [not yet created]
  get '/transcript', to: 'pages#transcript'
  # /app/views/pages/friends.html.erb [not yet created]
  get '/friends', to: 'pages#friends'

  #upload coruse or transcript
  get '/delete', to: 'uploads#delete'
  get '/upload_course', to: 'uploads#upload_course'
  post '/upload_transcript', to: 'uploads#upload_transcript'
  # ylno desu ateb

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
