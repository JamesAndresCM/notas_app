module Shared
  extend ActiveSupport::Concern
  # se crea un force_request para las acciones que solo se ejecutan a través de JS
  # ejemplo : modales.
  def force_request
    redirect_to root_path unless request.format == "text/javascript"
  end

  # pagination DRY
  def paginate_note(obj)
    obj.paginate(page: params[:page])
  end
end