Rails.application.routes.draw do
  resources :notifications
  resources :reports
  resources :views
  resources :shares
  resources :likes
  resources :post_categories
  resources :categories
  resources :comments
  resources :users do
    member do
      patch :activate_user
      put :activate_user
    end
  end
  resources :posts do
  collection do
    get 'by_author/:user_id', to: 'posts#by_author'
    get 'by_category/:category_id', to: 'posts#by_category'
    get 'analytics/:id', to: 'posts#post_analytics'
  end

end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end

