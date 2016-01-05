class Usuario < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # Habilitar login rede sociais
  # :omniauthable, :omniauth_providers => [:facebook, :linkedin]
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :papel
  validates_presence_of :nome

  def to_s
    nome
  end

  def self.params_permitt
    [:password, :password_confirmation]
  end

  def ability
    @ability ||= Ability.new(self)
  end
  
  def self.current
    return Thread.current[:current_usuario]
  end
  
  def self.current=(usuario)
    Thread.current[:current_usuario] = usuario
  end
  
  # Habilitar login rede sociais
  # def self.create_from_social(auth)
  #   usuario = Usuario.new
  #   usuario.link_social(auth)
  #   if auth.provider == 'facebook'
  #     usuario.facebook = auth.extra.raw_info.username
  #   elsif auth.provider == 'linkedin'
  #     usuario.linkedin = auth.info.urls.public_profile.split('/').last
  #   end
  #   usuario
  # end
  #
  # def self.from_omniauth(auth)
  #   where(provider: auth.provider, uid: auth.uid).first
  # end
  #
  # def link_social(auth)
  #   self.email = auth.info.email
  #   self.password = Devise.friendly_token[0,20]
  #   self.nome = auth.info.name
  #   self.remote_foto_url = auth.info.image
  #   self.provider = auth.provider
  #   self.uid = auth.uid
  # end
end
