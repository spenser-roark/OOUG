Ooug::Application.routes.draw do
  # You can have the root of your site routed with "root"
  root 'main_page#home'

  match '/home', to: 'main_page#home', via: 'get'
  match '/signUp', to: 'users#new', via: 'get'
  match '/about', to: 'main_page#about', via: 'get'
  match '/contact', to: 'main_page#contact', via: 'get'
  match '/inventory/test', to: 'inventory#test', via: 'get'
  match '/signIn',  to: 'sessions#new',         via: 'get'
  match '/signOut', to: 'sessions#destroy',     via: 'delete'

  get '/users/gruffBig' => 'users#gruffBig', as: 'gruffBig'
  get '/users/gruffSmall' => 'users#gruffSmall', as: 'gruffSmall'

  get '/inventory/games/:id' => 'inventory#games', as: 'inventory_games'
  get '/inventory/games/:id/:console_id' => 'inventory#games'

  get '/inventory/consoles/:id' => 'inventory#consoles', as: 'inventory_consoles'
  get '/inventory/consoles/:id/:console_id' => 'inventory#consoles'

  get '/inventory/accessories/:id' => 'inventory#accessories', as: 'inventory_accessories'
  get '/inventory/accessories/:id/:console_id' => 'inventory#accessories'

  get '/ownership/new/:id' => 'ownership#new', as: 'new_ownership'
  get '/console_ownership/new/:id' => 'console_ownership#new', as: 'new_console_ownership'

  get '/accessories_ownership/new/:id' => 'accessories_ownership#new', as: 'new_accessories_ownership'

  get '/games_wish_list/new/:id' => 'games_wish_list#new', as: 'new_games_wish_list'
  
  #get '/games_wish_list/:console_id' => 'games_wish_list#index', as: 'games_wish_list'

  resources :inventory, only: [:games, :consoles]
  resources :users
  resources :games
  resources :games_wish_list
  resources :browse_consoles
  resources :browse_accessories
  resources :consoles
  resources :accessories
  resources :console_general
  resources :console_ownership, only: [:show, :update, :edit, :create, :destroy, :new]
  resources :accessories_ownership, only: [:show, :update, :edit, :create, :destroy, :new]
  resources :region
  resources :ownership, only: [:show, :update, :edit, :create, :destroy, :new]
  resources :browse
  resources :search, only: [:index]
  resources :add_game, only: [:new, :create]
  resources :stats, only: [:show, :index]

  resources :sessions, only: [:new, :create, :destroy]

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
