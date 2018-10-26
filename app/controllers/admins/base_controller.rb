class Admins::BaseController < ActionController::Base
  include Admins::ApplicationHelper

  protect_from_forgery with: :exception

  layout 'admins/layouts/application'
end
