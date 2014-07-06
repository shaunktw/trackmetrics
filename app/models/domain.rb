class Domain
  include Mongoid::Document
  
  field :name, type: String
  field :url, type: String
  field :active, type: Boolean, default: false
  field :verification_token, type: String

  belongs_to :user

  before_create :generate_verification_token

  def verify!
    self.update_attribute(:active, true)
  end
  
  protected

  def generate_verification_token
    self.verification_token = SecureRandom.hex(30)
  end
end
