Rails.application.routes.draw do
  resources :reservations
  resources :advertisements
  resources :messages
  resources :advertisers
  resources :listings
  resources :owners
    root 'home#index'
    get 'login' => 'home#login'
    get 'signup' => 'home#signup'
    get 'world' => 'home#world'
    get 'search' => 'listings#search'
    get '/owner_dashboard', :controller => 'owners', :action => 'owner_dashboard'
    get '/owner_dashboard/mail', :controller => 'owners', :action => 'owner_dashboard_mail'
    get '/owner_dashboard/listings', :controller => 'owners', :action => 'owner_dashboard_listings'
    get '/advertiser_dashboard', :controller => 'advertisers', :action => 'advertiser_dashboard'
    get '/advertiser_dashboard/mail', :controller => 'advertisers', :action => 'advertiser_dashboard_mail'
    get '/advertiser_dashboard/ads', :controller => 'advertisers', :action => 'advertiser_dashboard_ads'
    get 'api/get_favorited_listings' => 'advertisers#get_favorited_listings'
    post 'api/unfavorite_listing' => 'advertisers#unfavorite_listing'
    post '/api/favorite_listing' => 'advertisers#favorite_listing'
    post '/api/confirm_payment' => 'reservations#confirm_payment'
    match '/api/signout', to: 'user#signoutUser', via: 'get'
    match '/api/login', to: 'user#loginUser', via: 'post'
    match '/api/create_user', to: 'user#createUser', via: 'post'
    match '/api/TESTAPI_resetUserFixture', to: 'user#resetFixture', via: 'get'
    match '/api/create_listing', to: 'listings#createListing', via: 'post'
    match '/api/get_listings', to: 'listings#getListings', via: 'post'
    match '/api/TESTAPI_resetListingsFixture', to: 'listings#resetFixture', via: 'get'
    match '/api/send_message', to: 'messages#sendMessage', via: 'post'
    match '/api/TESTAPI_resetMessageFixture', to: 'listings#resetFixture', via: 'get'
    match '/api/TESTAPI_resetAdvertisementFixture', to: 'advertisements#resetFixture', via: 'get'
    match '/api/TESTAPI_resetReservationFixture', to: 'reservations#resetFixture', via: 'get'
    match '/api/create_ad', to: 'advertisements#createAd', via: 'post'
    match '/api/TESTAPI_tests', to: 'application#tests', via: 'get'
    match '/api/create_listing_with_image', to: 'listings#createListingWithImage', via: 'post'
    match '/api/create_ad_with_image', to: 'advertisements#createAdWithImage', via: 'post'
    match '/api/reservations', to: 'reservations#get', via: 'get'
       #match 'listings/new', to: 'listing#new', via: 'get'

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
