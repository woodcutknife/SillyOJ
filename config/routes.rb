SillyOJ::Application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :hackers, path_prefix: "auth"
  root 'home#index'

  get 'hackers', to: 'g_hackers#index', as: 'hackers'
  get 'hackers/:id', to: 'g_hackers#show', as: 'hacker'

  get '/contests/:id/hackers', to: 'hackers#index', as: 'contest_hackers'

  get '/contests', to: 'contests#index', as: 'contests'

  get '/contests/:id', to: 'puzzles#index', as: 'contest_puzzles'
  get '/contests/:id/puzzles/:pid', to: 'puzzles#show', as: 'contest_puzzle'

  get '/contests/:id/solutions', to: 'solutions#index', as: 'contest_solutions'
  get '/contests/:id/solutions/new', to: 'solutions#new', as: 'contest_new_solution'
  get '/contests/:id/solutions/:sid', to: 'solutions#show', as: 'contest_solution'
  post '/contests/:id/solutions', to: 'solutions#create'

  get '/contests/:id/register', to: 'contests#register', as: 'contest_register'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
