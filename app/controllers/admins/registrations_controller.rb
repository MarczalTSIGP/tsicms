class Admins::RegistrationsController < Devise::RegistrationsController
  layout 'admins/layouts/application'

  protected
  def after_update_path_for(resource)
    edit_admin_registration_path
  end
end
