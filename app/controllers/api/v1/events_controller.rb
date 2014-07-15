class Api::V1::EventsController < Api::BaseController

  # POST /api/v1/events.json
  #
  # Params:
  # event_name: the name of the event
  # meta: all the meta data for the event as a hash
  def create
    # find the origin domain and authorize with current user
    if !current_user.authorized_domain_referer?(request.referer)
      respond_with({errors: "You are not allowed to record events for this domain", code: 401}, status: :unauthorized)
    else
      # add the event to the domain
      uri = URI.parse(request.referer)
      domain_name = "#{uri.scheme}://#{uri.host}"
      @event = current_user.domains.where(url: domain_name).events.build(name: params[:name], data: params[:data], uri: request.original_fullpath)  
      if @event.save
        respond_with({}, status: :created)
      else
        respond_with({errors: @event.errors.full_messages}, status: :unprocessable_entity)
      end
    end
    
  end

end