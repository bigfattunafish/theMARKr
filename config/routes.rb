Themarkr::Application.routes.draw do
  # get "sessions/new"

  root :to => 'home#index', as: 'home'

  get "/about" => 'users#about'

  get "/signup" => "sessions#sign_up", as: "sign_up"
  post "/signup" => "sessions#create_user", as: "create_user"
  get "/login"  => "sessions#new", as: "log_in"
  post "/login"  => "sessions#create", as: "open_session"
  get "/logout" => "sessions#destroy", as: "log_out"
  get "/goodbye" => "sessions#goodbye", as: "goodbye"
  get "/loading" => "sessions#loading", as: "loading"

  get '/:user_id/bylist/:list_id' => 'users#by_list', as: 'by_list'
  put '/:user_id/bylist/:list_id' => 'lists#edit_list', as: 'edit_list'
  get '/:user_id' => 'users#index', as: 'user_home'
  get '/:user_id/search' => 'users#search', as: 'search_result'
  post '/:user_id/save' => 'users#save', as: 'save_place'
  delete '/:user_id/delete' => 'places#delete', as: 'delete_place'

  get '/:user_id/:place_id' => 'users#show', as: 'show_place'
  put '/:user_id/:place_id/assign-to-list' => 'users#assign_to_list', as: 'assign_to_list'
  put '/:user_id/:place_id/edit-tags' => 'users#edit_tags', as: 'edit_tags'

  post '/:user_id/lists/create' => 'lists#create', as: 'create_list'
  delete '/:user_id/lists/delete' => 'lists#delete', as: 'delete_list'




  #     places GET    /places(.:format)          places#index
  #            POST   /places(.:format)          places#create
  #  new_place GET    /places/new(.:format)      places#new
  # edit_place GET    /places/:id/edit(.:format) places#edit
  #      place GET    /places/:id(.:format)      places#show
  #            PUT    /places/:id(.:format)      places#update
  #            DELETE /places/:id(.:format)      places#destroy

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
