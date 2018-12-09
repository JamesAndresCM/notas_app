class MainController < ApplicationController
  layout 'main'

  def index
    @contact = Main.new(params[:main])
  end

  def create
    begin
      @contact = Main.new(params[:main])
      @contact.request = request
        if @contact.deliver
          @contact = Main.new
          redirect_to root_path, notice: "Gracias por su mensaje. Pronto me pondré en contacto con usted"
        else
          render :index, notice: "Error al enviar mail"
        end
    rescue ScriptError
      redirect_to root_path, notice: 'Lo sentimos, este mensaje parece ser spam y no se entregó'
    end
  end
end
