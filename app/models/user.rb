class User
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  ## Database authenticatable
  field :name,               type: String
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""

  # API authentication
  field :authentication_token, type: String

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  ## Confirmable
  field :confirmation_token,   type: String
  field :confirmed_at,         type: Time
  field :confirmation_sent_at, type: Time
  field :unconfirmed_email,    type: String # Only if using reconfirmable

  validates_presence_of :name
  validates_uniqueness_of :name, :email, :case_sensitive => false

  has_many :domains
  has_many :events

  before_create :set_authentication_token
  
  def authorized_domain_referer?(request_origin)
    uri = URI.parse(request_origin)
    domain_name = "#{uri.scheme}://#{uri.host}:#{uri.port}/"
    #logger.info "domain_name -----> #{domain_name}"
    self.domains.where(url: domain_name).any?
  end

  private

  def set_authentication_token
    self.authentication_token = SecureRandom.hex(30)
  end
end
