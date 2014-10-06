Sonata::Application.routes.draw do
  root "welcome#index"

  match 'denied', to: 'denied#index', via: [:get]

  resources :services do
    resources :schedules
    resources :attachments
  end

  resources :roles do
    collection do
      get 'popup', :controller => 'popup', :action => 'popup_roles'
    end
  end

  match 'profile', to: 'profiles#index', via: [:get]
  match 'profile/edit', to: 'profiles#edit', via: [:get]
  match 'profile/update', to: 'profiles#update', via: [:patch]
  match 'profile/schedule', to: 'profiles#schedule', via: [:get]
  match 'profile/schedule/confirm/:id', to: 'schedules#confirm', via: [:get], as: "profile_schedule_confirm"
  match 'profile/schedule/reject/:id', to: 'schedules#reject', via: [:patch], as: "profile_schedule_reject"

  resources :people do
    collection do
      get 'popup', :controller => 'popup', :action => 'popup_people'
      # get 'level', :action => 'level_list'
    end

    member do
      get 'approve', :action => 'approve'
      post 'level/:role_id', :action => 'update_level', as: "update_level"
    end
  end

  # devise_for :people, path: "registration", :controllers => { :omniauth_callbacks => "omniauth_callbacks"}

  devise_for :people, path: "", :controllers => { :omniauth_callbacks => "omniauth_callbacks"},
    path_names: {
      sign_in: 'login',
      sign_out: 'logout',
      password: 'secret',
      confirmation: 'verification',
      unlock: 'unblock',
      registration: 'register',
      sign_up: 'new'
    }


  # No need to user this anymore since i figured how to customized URL for devise
  # devise_scope :person do
  #   get 'logout', :to => 'devise/sessions#destroy', :as => :omniauth_destroy_person_session
  # end

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
