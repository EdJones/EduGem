Whendidji3a::Application.routes.draw do
  resources :assessments

  resources :mchoices

  resources :bonus_rounds

  resources :game_levels

  match 'account/edit' => 'accounts#edit', :as => :edit_current_account

  match 'signup' => 'accounts#new', :as => :signup

  match 'logout' => 'user_sessions#destroy', :as => :logout

  match 'login' => 'user_sessions#new', :as => :login

match 'play' => 'play#start'
  resources :user_sessions

  resources :accounts

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

   resources :play do

   collection do
      get 'start'
      get 'gameUpdate'
      get 'gameUpdate2'
      get 'gameUpdate2a'
      get 'gameUpdate2b'
      get 'gameUpdate2bonus'
      get 'gameUpdate3p'
      get 'gameUpdate3b'
      get 'gameUpdate3z'
      get 'gameUpdate3v'
      get 'gameUpdate3bonus'
      get 'bonus2_result'
      post 'bonus2_result'
      get 'gameUpdate4a'
      get 'gameUpdate4b'
      get 'gameUpdate4w'
      get 'gameUpdate5h'
      get 'gameUpdate5i'
      get 'gameUpdateDone'
      get 'level_up'
      get 'bonus_result'
      post 'bonus_result'
      get 'start100'
    end
  end

     resources :practice 
     resources :my_games
     resources :my_digis do
        member do
            post 'new'
            get 'custom_events'
            get 'custom_event_add'
            get 'order'
            post 'custom_event_add'
            post 'custom_event_remove'
            post 'make_public'
            
            end
        end
     resources :custom_events
     resources :myAccount
     resources :event_suggestions
     resources :admin
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
   root :to => "play#start"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
