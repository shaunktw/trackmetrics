class Api::V1::EventsController < Api::BaseController
  # POST /api/v1/events.json
  #
  # Params:
  # event_name: the name of the event
  # meta: all the meta data for the event as a hash
   def create
     # find the origin domain and authorize with current user
     #logger.info "This is it ----> #{request.referer}, #{current_user.id}"
     if !current_user.authorized_domain_referer?(request.referer)
       #logger.current_user.authorized_domain_referer?.inspect
       respond_with({errors: "You are not allowed to record events for this domain", code: 401}, status: :unauthorized, location: nil)
     else
       # add the event to the domain
       uri = URI.parse(request.referer)
       if [80,443].include?(uri.port)
        domain_name = "#{uri.scheme}://#{uri.host}/"
      else
        domain_name = "#{uri.scheme}://#{uri.host}:#{uri.port}/"
      end
       @event = current_user.domains.where(url: domain_name).first.events.build(name: params[:name], data: params[:data], uri: request.referer, visitor_ip: request.remote_ip) 
       if @event.save
         respond_with({}, status: :created, location: nil)
       else
         respond_with({errors: @event.errors.full_messages}, status: :unprocessable_entity, location: nil)
       end
     end
    
   end

end