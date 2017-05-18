Rails.application.routes.draw do
  devise_for :admins
  resources :hires do
    get :checkin, on: :collection
  end
  resources :children do
    get :previous_year, on: :collection
  end
  resources :books do
    get :editall, on: :collection
    get :index_by_letter, on: :collection
  end
  resources :genres

  get "/fetch_books" => 'hires#from_category', as: 'fetch_books'
  get "/fetch_children" => 'hires#from_class', as: 'fetch_children'
  get "/search_checkin" => 'hires#search_checkin', as: 'search_checkin'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'books#home'

  # Example of regular route:
  get '/', to: 'books#home', as: 'home'
 # get '/books/check_in', to: 'books#checkin', as: 'checkin'
 # get '/books', to: 'books#editall', as: 'editall'
  # get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
   #  resources :books do
   #      get :checkin, on: :collection
   #      get :editall, on: :collection
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
