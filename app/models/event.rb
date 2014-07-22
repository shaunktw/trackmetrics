class Event
  include Mongoid::Document
  include Mongoid::Timestamps
  include Geocoder::Model::Mongoid
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

  after_create :get_geocode

  def get_location_details
    if self.visitor_ip.present?
      location_data = Geocoder.search(self.visitor_ip).first
      self.visitor_country = location_data.country
      self.visitor_region = location_data.province
      self.visitor_city = location_data.city
      self.latitude = location_data.latitude
      self.longitude = location_data.longitude
      self.save
    end
  end

  protected

  def get_geocode
    EventWorker.perform_async(self.id.to_s)
  end
end
