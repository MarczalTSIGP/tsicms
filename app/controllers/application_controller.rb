class ApplicationController < ActionController::Base
  layout :layout_by_resource

  def after_sign_in_path_for(resource)
    return admins_root_path if resource.is_a?(Admin)

    root_path
  end

  def after_sign_out_path_for(resource)
    return new_admin_session_path if resource == :admin

    root_path
  end

  protected
  def layout_by_resource
    case namespace_name
    when 'devise'
      'devise/layouts/application'
    else
      'layouts/application'
    end
  end

  def namespace_name
    path = controller_path.split('/')
    path.second ? path.first : nil
  end

end
