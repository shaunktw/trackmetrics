class Api::V1::EventsController < Api::BaseController

  def create
    @event = params.require(:event).permit(:name,:impression, :click)
    @domain = Domain.find_by_name(@event[:name])

    if @domain.nil?
      flash[:error] = "Your domain was not found. Event not created!"
    else
      flash[:notice] = "Your domain event was created successfully!"
      @new_event = @domain.events.build(params.require(:event).permit(:name, :impression, :click))
      @new_event.save
    end

    respond_with(@new_event, :location => domain_url)

  end

end