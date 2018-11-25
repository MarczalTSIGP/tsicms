Rails.application.routes.draw do
  localized do
    root to: 'home#index'
    get '/pages/:permalink', to: 'static_pages#index', as: 'static_page'
    get '/pages/:static_page_id/history', to: 'static_pages#history', as: 'static_page_history'
    resources :professors, only: [:index, :show]
    resources :companies, only: [:index, :show]
    resources :trainees, only: [:index, :show]
    resources :activities, only: [:index, :show]
    resources :discipline_monitors, only: [:index, :show]

    resources :professors,
              :trainees,
              :companies,
              :activities,
              :discipline_monitors do
      get 'page/:page', action: :index, on: :collection
    end

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
        resources :static_pages do
          get 'history', to: 'static_pages#history'
        end
        resources :discipline_monitors
        resources :monitor_types
        resources :trainees
        resources :category_recommendations,
                  :recommendations,
                  :academics,
                  :professors,
                  :companies,
                  :activities,
                  :activity_professors,
                  :matrices,
                  :faqs,
                  :static_pages,
                  :discipline_monitors,
                  :monitor_types,
                  :trainees do
          get 'page/:page', action: :index, on: :collection
        end
      end
    end
  end
end
