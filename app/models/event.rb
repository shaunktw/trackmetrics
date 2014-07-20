class Event
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :data,  type: Hash, default: {}
  field :uri,   type: String
  field :visitor_ip, type: String
  field :visitor_country, type: String
  field :visitor_region, type: String
  field :visitor_city, type: String
  field :latitude, type: Float
  field :longitude, type: Float

  belongs_to :domain
  belongs_to :user

end
