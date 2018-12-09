class NotesController < ApplicationController
  # concern shared (pagination ,force_request)
  include Shared
  # helper solo 1 variable de instancia @note
  helper_method :note
  # cancancan permisos
  load_and_authorize_resource
  # action callbacks 
  before_action :authenticate_user!
  before_action :set_note, only: %i(show edit destroy update)
  before_action :categories_notes, only: %i(ocio student work week today)
  before_action :force_request, only: %i(show search_date)

  # actions que solo reciben variable de instancia
  def index; end
  def show; end
  def edit; end
  def new; end
  def ocio; end
  def student; end
  def work; end
  def week; end
  def today; end

  def destroy
    redirect_to notes_path, notice: 'Nota destruída correctamente' if note.destroy
  end

  def create
    if note.save
      redirect_to notes_path, notice: 'Nota creada correctamente'
    else
      render :new
    end
  end

  def update
    if note.update(note_params)
      redirect_to notes_path, notice: 'Nota actualizada correctamente'
    else
      render :edit
    end
  end

  # realiza el render de un modal para filtrar por fechas
  def search_date_note
    render js: 'notes/search_date.js.erb'
  end

  # muestra las notas por fechas obtenidas del modal (se utiliza search_service)
  # para delegar este proceso, se añade excepción para evitar parametros no deseados
  # enviados a través de la url
  def result_date
    begin
      if note.blank?
        redirect_to root_path, notice: 'No se encontraron resultados'
      else
        render template: "notes/index", locals: { note: note, title: 'Notas Encontradas' }
      end
    rescue
      redirect_to notes_path, notice: "Error #{params[:search].parameterize}"
    end
  end

  # búsqueda de notas por título
  def search_title
    if note.blank?
      redirect_to root_path, notice: 'No se encontraron resultados'
    else
      render template: "notes/index", locals: { note: note, title: "Resultados Obtenidos" }
    end
  end

  private

  def set_note
    begin
      @note = Note.friendly.find(params[:id]).decorate
    rescue
      redirect_to notes_path, notice: 'Nota no encontrada'
    end
  end

  def note_params
    params.require(:note).permit(:title, 
                                  :user_id,  
                                  :description,
                                  :category_id,
                                  :img,
                                  :created_at,
                                  :img_cache
                                )
  end

  # asignación de variable de instancia
  def note
    @note ||=
    case action_name
    when "index"
      paginate_note(current_user.notes)
    when "new"
      Note.new
    when "create"
      current_user.notes.build(note_params)
    when "ocio"
      paginate_note(current_user.note_category("ocio"))
    when "work"
      paginate_note(current_user.note_category("trabajo"))
    when "student"
      paginate_note(current_user.note_category("estudios"))
    when "result_date"
      paginate_note(SearchService.search_date(params,current_user))
    when "week"
      paginate_note(Note.this_week(current_user))
    when "today"
      paginate_note(Note.today_note(current_user))
    when "search_title"
      paginate_note(Note.search_by_title(params[:search_title],current_user))
    else
      set_note rescue nil
    end
  end

  # se establece un título por cada accion y se redirige al template principal index,
  # con los resultados correspondientes
  def categories_notes
    title = 
    case action_name
    when "ocio"
      "Notas de Ocio"
    when "work"
      "Notas de Trabajo"
    when "student"
      "Notas de Estudios"
    when "week"
      "Notas Semanales"
    when "today"
      "Notas para hoy"
    else
      nil
    end
    render template: "notes/index", locals: { note: note, title: title }
  end

end

