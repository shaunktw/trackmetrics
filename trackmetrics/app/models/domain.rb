class Domain
  include Mongoid::Document
  field :name, type: String
  field :url, type: String

  belongs_to :user
end
