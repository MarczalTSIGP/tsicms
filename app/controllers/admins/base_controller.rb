class Admins::BaseController < ActionController::Base
  include Admins::ApplicationHelper

  protect_from_forgery with: :exception

  layout 'admins/layouts/application'

  add_breadcrumb I18n.t('breadcrumbs.homepage'), :admins_root_path
end
