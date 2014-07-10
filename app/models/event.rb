class Event
  include Mongoid::Document
  field :name, type: String
  field :impression, type: Integer
  field :pageview, type: Integer
  field :click, type: Integer

  belongs_to :domain
  belongs_to :event 
end
