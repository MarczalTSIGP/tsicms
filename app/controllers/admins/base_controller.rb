class Admins::BaseController < ActionController::Base
  before_action :find_fixed_pages
  include FlashMessage
  include Admins::ApplicationHelper

  protect_from_forgery with: :exception

  layout 'admins/layouts/application'

  add_breadcrumb I18n.t('breadcrumbs.homepage'), :admins_root_path

  protected
  def find_fixed_pages
    @static_pages = StaticPage.where(fixed: true)
  end
end
