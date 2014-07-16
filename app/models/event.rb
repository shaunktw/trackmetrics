class Event
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :data,  type: Hash, default: {}
  field :uri,   type: String


  belongs_to :domain
  belongs_to :user
end
