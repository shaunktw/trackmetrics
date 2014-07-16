class EventsController < ApplicationController

  before_filter :authenticate_user!

  def index
    @domain = Domain.where(id: params[:domain_id]).first
    @events = @domain.events
  end
end
