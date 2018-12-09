class NoteDecorator < Draper::Decorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  # si existe imagen se renderiza, en caso contrario se utiliza el default.jpg
  def img_note
    if object.img?
      h.image_tag(object.img.url, alt: "#{object.title}" , title: "#{object.title}", id: 'post_prev', class:'img-fluid mt-2 avatar_profile')
    else 
      h.image_tag('fallback/default.jpg',  id: 'post_prev', class:'img-fluid mt-2 avatar_profile')
    end
  end

  # generic, cambia el estilo de la imagen del objeto
  def image_card(class_style)
    h.image_tag(object.img.url, alt: "#{object.title}" , title: "#{object.title}" , class: class_style)
  end

  # valor de la fecha al pasarla en calendario de inserción/edit
  def value_datetime
    if object.created_at 
      created_at
    else 
      DateTime.now.strftime("%d-%m-%Y %H:%M:%S")
    end
  end

  # title capitalize
  def note_title
    object.title.capitalize
  end

  # formato de fecha
  def created_at
    object.created_at.strftime("%d-%m-%Y %H:%M") 
  end

  # avatar de usuario
  def user_avatar
    object.user.avatar.url
  end

  #link_to not working https://github.com/nicolasblanco/sweet-alert2-rails/issues/8
  def delete_icon
    h.form_for object, method: :delete do
      h.button_tag class: 'btn btn-sm', 
      data: { 
        confirm: "Desea eliminar esta nota ?", 
        'sweet-alert-type': 'error', customClass: "Custom_Cancel" } do
        h.content_tag :i, nil, style: 'color: red; font-size: x-large', class: 'fa fa-trash'
      end
    end
  end


  # link para editar nota
  def edit_icon(link_text = nil)
    delete_icon_filename = 'pencil-square-o'
    h.link_to h.fa_icon(delete_icon_filename, style: 'font-size: x-large') + link_text, 
              h.edit_note_path(object)
  end

  # devuelve distancia de fecha 
  # https://rails-bestpractices.com/posts/2012/02/10/not-use-time_ago_in_words/
  def time_ago
    h.timeago_tag object.created_at, nojs: true, force: true, lang: :es
  end

  def time_left
    time_note = (object.created_at.to_date - Time.now.to_date).to_i
    case 
    when time_note > 2
      "Faltan #{time_note} días."
    when time_note == 1
      "Importante! nota para Mañana."
    when time_note == 0
      "Nota para Hoy!"
    else
      "Expiró el tiempo."
    end        
  end

  def humanize_date
    l(object.created_at,format: '%d %B de %Y a las %H:%M horas.')
  end
end
