class Admins::RegistrationsController < Devise::RegistrationsController
  include Admins::LastMessages

  layout 'admins/layouts/application'

  protected

  def after_update_path_for(_resource)
    edit_admin_registration_path
  end
end
