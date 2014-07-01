class EventsController < ApplicationController
  def index
    @events = Event.all
    respond_to do |format|
      format.json{ render json: @events }
  end

  def new
  end

  def show
  end

  def edit
  end

  def create
  end

  def update
  end

end
