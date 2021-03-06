Rails.application.routes.draw do

  root "pages#index"

  get "/auth/:provider/callback",  to: "sessions#create",    as: :login
  post "/auth/:provider/callback", to: "sessions#create"

  get "/sign-out",                 to: "sessions#destroy",   as: :sign_out

  get "/users/:id",                to: "users#show",        as: :show
  patch "/users/:id",              to: "users#update"

  # post "/add_subscription",    to: "subscriptions#create", as: :add_subscription
  post "/remove_subscription",    to: "subscriptions#destroy", as: :remove_subscription
  post "/subscriptions",         to: "subscriptions#create",    as: :subscriptions


  get "/search", to: "pages#user_search", as: :user_search
  get "/watup",  to: "pages#landing",     as: :landing_page

  post "/search", to: "pages#user_search"
  # post "/unsubscribe-searchresult",      to: "subscriptions#destroy"

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
