class Admins::BaseController < ActionController::Base
  include Admins::ApplicationHelper
  include Admins::LastMessages
  include FlashMessage

  before_action :find_fixed_pages

  protect_from_forgery with: :exception

  layout 'admins/layouts/application'

  add_breadcrumb I18n.t('breadcrumbs.homepage'), :admins_root_path

  protected

  def find_fixed_pages
    @static_pages_on_menu = StaticPage.where(fixed: true)
  end
end
