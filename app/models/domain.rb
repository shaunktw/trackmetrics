class Domain
  include Mongoid::Document
  
  field :name, type: String
  field :url, type: String
  field :active, type: Boolean, default: false
  field :verification_token, type: String

  validates :name, length: {minimum: 5}, presence: true
  validates_uniqueness_of :url 
  validates_format_of :url, :with => URI::regexp(%w(http https http://))

  belongs_to :user
  has_many :events

  before_create :generate_verification_token

  def verify!
    self.update_attribute(:active, true)
  end
  
  protected

  def generate_verification_token
    self.verification_token = SecureRandom.hex(30)
  end
end
