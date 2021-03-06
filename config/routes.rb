Sonata::Application.routes.draw do
  root "welcome#index"

  match 'activities', to: "welcome#activities", via: [:get]
  match 'denied', to: 'denied#index', via: [:get]
  # match 'calendar_feed_events', to: 'services#calendar_feed_events', via: [:get]

  resources :services do
    collection do
      get 'show_new_calendar', :action => 'show_new_calendar'
      # get 'calendar_feed_events', :action => 'calendar_feed_events'
    end
    resources :schedules
    resources :attachments
  end

  match 'confirm/:random_id', to: 'schedules#confirm_from_email_view', via: [:get], as: "confirm_from_email"
  match 'confirm/:random_id', to: 'schedules#confirm_from_email', via: [:patch]

  match 'reject/:random_id', to: 'schedules#reject_from_email_view', via: [:get], as: "reject_from_email"
  match 'reject/:random_id', to: 'schedules#reject_from_email', via: [:patch]

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

  devise_for :people, path: "", :controllers => { :omniauth_callbacks => "omniauth_callbacks", :registrations => "registrations" },
    path_names: {
      sign_in: 'login',
      sign_out: 'logout',
      password: 'secret',

      # Commented because we want to invite-only-member
      # confirmation: 'verification',
      # unlock: 'unblock',
      # registration: 'register',
      # sign_up: 'new'
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
