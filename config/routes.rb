Rails.application.routes.draw do
  root to: 'home#index'
  get '/static_pages/:permalink', to: 'static_pages#index', as: 'static_page'

  #========================================
  # Admin
  #========================================
  as :admin do
    get '/admins/edit' => 'admins/registrations#edit', :as => 'edit_admin_registration'
    put '/admins' => 'admins/registrations#update', :as => 'admin_registration'
  end

  devise_for :admins
  authenticate :admin do
    namespace :admins do
      root to: 'dashboard#index'
      resources :academics
      resources :activities
      resources :activity_professors, excepty: [:show]
      resources :category_recommendations, excepty: [:show]
      resources :recommendations, excepty: [:show]
      resources :professors
      resources :static_pages, excepty: [:show]
    end
  end
  #========================================
end
