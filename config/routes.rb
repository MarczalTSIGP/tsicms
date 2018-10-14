Rails.application.routes.draw do
  root to: 'home#index'

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

      resources :faqs
      resources :professors
      resources :category_recommendations
      resources :recommendations
      resources :academics
      resources :activities
      resources :activity_professors, excepty: [:show]
    end
  end
  #========================================
end
