class Note < ApplicationRecord
  
  # pagination
  self.per_page = 10

  # relationships
  belongs_to :user, inverse_of: :notes
  belongs_to :category, inverse_of: :notes
  validates_associated :user

  # scopes default scope "is a bad practice" but, solo se esta empleando en
  # ordenar el objeto si se requiere saltar el default_scope en este caso se utiliza reorder en
  # la consulta requerida
  default_scope { order(created_at: :desc) }

  # scope que retorna el titulo de una nota de un usuario
  scope :search_by_title, ->(title, user) { where("title ilike ?","%#{title}%").where(user_id: user) }
  
  # scope que busca notas por rango de fecha para un usuario
  scope :search_by_date, -> (start_date, end_date,user) {
    where('created_at::date BETWEEN ? AND ?',start_date,end_date)
    .where(user_id: user)
  }

  # scope que retorna semana actual por usuario
  scope :this_week, ->(user) { 
    where('created_at::date BETWEEN ? AND ?',Date.today.at_beginning_of_week, Date.today.at_end_of_week)
    .where(user_id: user) 
  }


  # scope que retorna notas del dia
  scope :today_note, ->(user){
    where("DATE(created_at) = ?", Date.today).where(user_id: user)
  }

  # friendly url
  extend FriendlyId
  friendly_id :title, use: :slugged

  # carrierwave uploader
  mount_uploader :img, ImgUploader


  # validations
  before_validation :capitalize_title

  # validación de atributo titulo entre 3 y 100 como máx 
  # no se admiten caracteres especiales, utiliza scope único a fin de omitir titulos iguales
  validates :title, presence: true, uniqueness: { scope: :user_id },
            length: { in: 3..100 , message: 'mínimo 3 máximo 100 caracteres'},
            format: { with: /\A[a-zA-ZñÑáéíóúÁÉÍÓÚ0-9_ ]+\z/,
            message: 'solo números o letras' }

  # validación de descripción de una nota, largo de entre 3 y 300
  validates :description, presence: true, length: { in: 3..300 , message: 'mínimo 3 máximo 300 caracteres'}
  
  # validación de tamaño de imagen
  validates :img, file_size: { less_than: 2.megabytes }

  # presencia de attributo created_at
  validates :created_at, presence: true

  # valida que fecha sea mayor a año actual y no este en blanco (backend)
  validate :created_at_greater?

  # delegación de atributo en vez de note.user.username... obj.user_username
  delegate :username, to: :user, prefix: true

  # delegación de atributo en vez de note.category.name... obj.category_name
  delegate :name, to: :category, prefix: true

  private 

  # se guarda atributo título con primera letra en mayuscula
  def capitalize_title
    self.title = title.capitalize if title?
  end

  # se actualiza friendly id
  def should_generate_new_friendly_id?
    title_changed?
  end

  def created_at_greater?
    if created_at.blank?
      errors.add(:base, "no puede estar vacio")
    elsif created_at.to_date.year < 2018
      errors.add(:base, "el año debe ser mayor o igual a 2018")
    end
  end
end
