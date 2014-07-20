class EventsController < ApplicationController

  before_filter :authenticate_user!

  def index
    @domain = Domain.find_by(id: params[:domain_id])
    @events = @domain.events

    @pie_graph_events = @events.group_by(&:name)
    @pie_graph_events.each_pair do |key, val|
      @pie_graph_events[key] = val.count
    end
   
   @bar_graph_events = @events.group_by{|event| event.created_at.beginning_of_day}
   @bar_graph_events_day = {}
   @bar_graph_events.sort.each do |day, events|
      @bar_graph_events_day[day] = events.count
   end
   
   
end

end