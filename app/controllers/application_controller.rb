class ApplicationController < ActionController::Base
  include DeviseWhitelist
  include CancanWarning

  def routing
    respond_to do |format|
      error = ActionController::RoutingError.new("La página #{request.path.tr("/","")} no ha sido encontrada ")
      format.html { redirect_to root_path , notice: error }
    end
  end
end
