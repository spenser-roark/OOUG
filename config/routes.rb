Ooug::Application.routes.draw do
  # You can have the root of your site routed with "root"
  root 'main_page#home'

  if Rails.env.production?
    get '/not_found', :to => 'application#page_not_found'
  end

  # Main
  match '/home', to: 'main_page#home', via: 'get'
  match '/help', to: 'main_page#help', via: 'get'
  match '/signUp', to: 'users#new', via: 'get'
  match '/about', to: 'main_page#about', via: 'get'
  match '/contact', to: 'main_page#contact', via: 'get'
  match '/inventory/test', to: 'inventory#test', via: 'get'
  match '/signIn',  to: 'sessions#new',         via: 'get'
  match '/signOut', to: 'sessions#destroy',     via: 'delete'

  # Gruff
  get '/users/gruffBig' => 'users#gruffBig', as: 'gruffBig'
  get '/users/gruffSmall' => 'users#gruffSmall', as: 'gruffSmall'
  get '/users/gruffBigAcc' => 'users#gruffBigAcc', as: 'gruffBigAcc'
  get '/users/gruffSmallAcc' => 'users#gruffSmallAcc', as: 'gruffSmallAcc'
  get '/users/gruffConsole' => 'users#gruffConsole', as: 'gruffConsole'
  get '/users/gruffWish' => 'users#gruffWish', as: 'gruffWish'

  #  General Wish Lists
  get '/wish_list/games/:id' => 'wish_list#games', as: 'wish_list_games'
  get '/wish_list/games/:id/:console_id' => 'wish_list#games', as: 'wish_list_game'

  get '/wish_list/accessories/:id' => 'wish_list#accessories', as: 'wish_list_accessories'
  get '/wish_list/accessories/:id/:console_id' => 'wish_list#accessories', as: 'wish_list_accessory'

  get '/wish_list/consoles/:id' => 'wish_list#consoles', as: 'wish_list_consoles'
  get '/wish_list/consoles/:id/:console_id' => 'wish_list#consoles', as: 'wish_list_console'
  
  # Inventories
  get '/inventory/games/:id' => 'inventory#games', as: 'inventory_games'
  get '/inventory/games/:id/:console_id' => 'inventory#games', as: 'inventory_game'

  get '/inventory/consoles/:id' => 'inventory#consoles', as: 'inventory_consoles'
  get '/inventory/consoles/:id/:console_id' => 'inventory#consoles', as: 'inventory_console'

  get '/inventory/accessories/:id' => 'inventory#accessories', as: 'inventory_accessories'
  get '/inventory/accessories/:id/:console_id' => 'inventory#accessories', as: 'inventory_accessory'

  # Ownerships
  get '/ownership/new/:id' => 'ownership#new', as: 'new_ownership'
  get '/console_ownership/new/:id' => 'console_ownership#new', as: 'new_console_ownership'
  get '/accessories_ownership/new/:id' => 'accessories_ownership#new', as: 'new_accessories_ownership'

  # Specific Wish Lists
  get '/games_wish_list/new/:id' => 'games_wish_list#new', as: 'new_games_wish_list'
  get '/accessories_wish_list/new/:id' => 'accessories_wish_list#new', as: 'new_accessories_wish_list'  
  get '/consoles_wish_list/new/:id' => 'consoles_wish_list#new', as: 'new_consoles_wish_list'  

  # Resources
  resources :inventory, only: [:games, :consoles, :accessories]
  resources :users
  resources :games
  resources :wish_list
  resources :games_wish_list
  resources :accessories_wish_list
  resources :consoles_wish_list
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
  resources :application, only: [:page_not_found]

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
  if Rails.env.production?
    get '*path' => redirect('/not_found')
  end
end
