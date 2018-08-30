Rails.application.routes.draw do
  root to: 'home#index'

  #========================================
  # Admin
  #========================================
  namespace :admins do
    root to: 'dashboard#index'
  end
  #========================================
end
