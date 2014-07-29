class EventsController < ApplicationController

  before_filter :authenticate_user!

  def index
    @domain = Domain.find_by(id: params[:domain_id])
    @events = @domain.events.paginate :page => params[:page], :per_page => 10
    @events_csv = @domain.events.all

    @pie_graph_events = @events.group_by(&:name)
    @pie_graph_events.each_pair do |key, val|
      @pie_graph_events[key] = val.count
    end
   
   @bar_graph_events = @events.group_by{|event| event.created_at.beginning_of_day}
   @bar_graph_events_day = {}
   @bar_graph_events.sort.each do |day, events|
      @bar_graph_events_day[day] = events.count
   end

   respond_to do |format|
    format.html
    format.csv { send_data @events_csv.to_csv }
    format.xls # { send_data @events.to_csv(col_sep: "\t") }
  end  
end

end