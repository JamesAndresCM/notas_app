class Auth::RegistrationsController < Devise::RegistrationsController
  # actualizar cuenta de facebook sin utilizar contraseña
  def update_resource(resource, params)
    if current_user.provider == "facebook"
      params.delete("current_password")
      resource.update_without_password(params)
    else
      resource.update_with_password(params)
    end
  end
end