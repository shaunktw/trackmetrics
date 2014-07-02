class Domain
  include Mongoid::Document
  field :name, type: String
  field :url, type: String

  belongs_to :user, foreign_key: :user_id
end
