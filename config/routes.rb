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

      resources :category_recommendations, excepty: [:show]
      resources :recommendations, excepty: [:show]
      resources :academics
      resources :professors do
        resources :periods_professors, as: :periods
      end
      resources :activities
      resources :activity_professors, excepty: [:show]
      resources :matrices, :periods, :disciplines 
      resources :faqs
      resources :static_pages, excepty: [:show]
      
    end
  end
  #========================================
end
