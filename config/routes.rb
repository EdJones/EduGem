Whendidji3a::Application.routes.draw do


  match 'account/edit' => 'accounts#edit', :as => :edit_current_account

  match 'signup' => 'accounts#new', :as => :signup

  match 'logout' => 'user_sessions#destroy', :as => :logout

  match 'login' => 'user_sessions#new', :as => :login

  match 'play' => 'play#start'

  
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


   resources :play do
    
		member do

		end
    
   collection do
      get 'start'
      get 'level'
      get 'gameUpdate'
      get 'gameUpdateDone'
      get 'level_up'
      get 'bonus_result'
      post 'bonus_result'
    end
  end

     resources :practice do
		member do
			get 'show'
		end
	 end
     resources :my_games do
         member do
             get 'my_digis'
             get 'select_digis'
             post 'select_digis'
             post 'my_digi_add'
             post 'my_digi_remove'
         end
         
         collection do
             get 'admin'
         end
     end
     
     resources :my_digis do
        member do
            post 'new'
            get 'custom_events'
            get 'custom_event_add'
            get 'order'
            post 'custom_event_add'
            post 'custom_event_remove'
            post 'make_public'
            get 'my_games'
            post 'select_games'
            
            end
        collection do
             get 'admin'
         end
        end
     resources :custom_events do
		member do
			post 'new'
			post 'update'
		end
        collection do
            get 'admin'
        end
     end
  resources :user_sessions

  resources :accounts do
    collection do
		get 'subscribe'
		end
	end
		
  resources :accounts do as_routes end

  resources :users do as_routes end

  resources :assessments do
      member do
                post 'new'
       end
   end

  resources :bonus_rounds
  
  resources :traffics
  
  resources :users_admin
  
  resources :game_stat

  resources :game_levels
  
  resources :invites
  
  resources :users do
      
      collection do
          get 'new'
      end
  end     
     resources :myAccount
     resources :event_suggestions
     resources :admin do
         collection do
             get 'index'
             get 'admin'
         end
     end
    resources :admin_custom
    resources :admin_events
    resources :admin_didjis
     
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
