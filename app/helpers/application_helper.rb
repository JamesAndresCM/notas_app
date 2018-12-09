module ApplicationHelper
  def alerts
    alert = (flash[:alert] || flash[:error] || flash[:notice])
    if alert
      js add_gritter(alert, title: "Notificación" ,sticky: false, time: 3000)
    end
  end

  def title_default
    @page_title = "Note App"
  end
end
