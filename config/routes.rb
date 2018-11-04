Rails.application.routes.draw do
  localized do
    root to: 'home#index'
    get '/static_pages/:permalink', to: 'static_pages#index', as: 'static_page'
    get '/activities', to: 'activities#index'
    get '/activity/:id', to: 'activities#show'
    get '/trainees', to: 'trainees#index'
    get '/trainee/:id', to: 'trainees#show'
    get '/tcc', to: 'static_pages#tcc'
    get '/monitors', to: 'static_pages#monitor'
    get '/companies', to: 'companies#index'
    get '/company/:id', to: 'companies#show'
    get '/professors', to: 'professors#index'
    get '/professor/:id', to: 'professors#show'
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
        resources :professors
        resources :companies
        resources :activities
        resources :activity_professors, excepty: [:show]
        resources :matrices, :periods, :disciplines
        resources :faqs
        resources :static_pages, excepty: [:show]
        resources :discipline_monitors
        resources :monitor_types
        resources :trainees
        get '/static_page/trainee', to: 'static_pages#trainee'
        get '/static_page/tcc', to: 'static_pages#tcc'
        get '/static_page/monitor', to: 'static_pages#monitor'
      end
    end
    #========================================
  end
end
