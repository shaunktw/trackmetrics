class EventsWorker
  include Sidekiq::Worker 

  def perform(event_id)
    event = Event.find(event_id)
    event.get_location_details
  end
end