class Admins::BaseController < ActionController::Base
  protect_from_forgery with: :exception

  layout 'admins/layouts/application'
end
