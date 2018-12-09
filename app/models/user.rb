class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :async, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :omniauthable, omniauth_providers: [:facebook]

  has_many :notes, dependent: :destroy, inverse_of: :user
  
  mount_uploader :avatar, AvatarUploader
  extend FriendlyId
  friendly_id :username, use: :slugged
  
  validates :email, presence: true,
            uniqueness: { allow_blank: true, case_sensitive: false },
            length: { maximum: 50 },
            email: true,
            allow_blank: true

  validates :username, presence: true, uniqueness: true, 
            length:  {in: 3..50}, 
            format: { with: /\A[a-zA-ZnÑáéíóúÁÉÍÓÚ0-9_ ]+\z/, message: 'nombre de usuario no valido' }

  validates_confirmation_of :password

  before_validation :format_user_data
  before_create :set_default_role

  enum role: {
    user: 0,
    admin: 1
  }.freeze

  def self.from_omniauth(auth)
    #busco user en bd resultado con uid y provider
    user = self.where(provider: auth.provider, uid: auth.uid).first 
    #si no existe usuario creo uno nuevo con el provider
    unless user
      user = User.new(
        email: User.get_email(auth),
        provider: auth.provider,
        uid: auth.uid,
        password: Devise.friendly_token[0,20],
        username: auth.info.name
      )
      #salto la confirmacion (email confirmation)
      user.skip_confirmation!
      #guardo en bd el usuario
      user.save
    end
    #pregunto si existe la imagen
    if auth.info.image
      #si es asi guardo el remote_url para el perfil
      user.update_attribute(:remote_avatar_url, auth.info.image)
    end
    #retorno user(en caso de existir)
    user
  end

  def format_user_data
    self.email = email.downcase if email?
    self.username = username.capitalize if username?
  end

  def set_default_role
    self.role ||= :user
  end

  def should_generate_new_friendly_id?
    username_changed?
  end

  def note_category(category) 
    notes.joins(:category).where("categories.name = (?)","#{category}") 
  end
  
private
  #si el email no existe se crea uno provider + uid
  def self.get_email(auth)
    auth.info.email || "#{auth.provider}-#{auth.uid}@example.com"
  end
end
