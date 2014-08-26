Banterraptor::Application.routes.draw do


  resources :groups do
    member do
      get :users, :statuses
    end
  end
  resources :profiles

  get "profiles/show"
  resources :groups
  resources :memberships


  get "static_pages/home"
  get "static_pages/about"
  get "static_pages/group_page"
  resources :authentications
  match '/auth/:provider/callback' => "authentications#create", via: [:get] 
  devise_for :users, :controllers => {:registrations => 'registrations'}
  resources :groups do
    resources :statuses, :only => [:create, :update]
  end
  resources :statuses do
    member { post :like }
  end
  resources :groups, only: [:show], shallow: true do
    resources :memberships, :only => [:create, :update]
  end

  resources :groups, only: [:show], shallow: true do
   resources :membership, only: [:new] #-> domain.com/2/memberships/new
end

resources :groups do
   resources :memberships, only: [:destroy] #-> domain.com/2/memberships/new
end


  resources :profiles do
  member do
    get :groups
  end
end

get 'static_pages/:id/group_page' => 'static_pages#group_page'
  


  root 'static_pages#home'
  
  get ':id' => 'profiles#show', :as => :profile_show

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
