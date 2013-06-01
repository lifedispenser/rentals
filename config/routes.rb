Rentals::Application.routes.draw do
  devise_for :users, :controllers => {:registrations => "users/registrations", :passwords => "users/passwords"}
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root to: 'welcome#index'

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

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
  get 'mr_rogers' => 'mr_rogers/dashboard#index'
  
  namespace :mr_rogers do
    resources :rentals do
      post 'publish'
      post 'unpublish'
    end
    resources :photos, except: [:edit]
  end

  get 'rentals/pet_friendly' => 'rentals#index', pet_friendly: true, as: 'pet_friendly_rentals'
  get 'rentals/kid_friendly' => 'rentals#index', kid_friendly: true, as: 'kid_friendly_rentals'
  get 'rentals/long_term' => 'rentals#index', long_term: true, as: 'long_term_rentals'
  resources :rentals, only: [:show, :index]
  resources :contacts, only: [:create]
end
