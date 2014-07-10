class DomainsController < ApplicationController

  before_filter :authenticate_user!

  def index
    @domains = current_user.domains 
    authorize @domains
  end

  def show
    @domain = current_user.domains.find(params[:id])
    @events = @domain.events
    @event_week = @events.group_by {|event| event.created_at.beginning_of_week}
    authorize @domain 
  end

  def new
    @domain = current_user.domains.build
    authorize @domain
  end

  def create
    @domain = current_user.domains.build(params.require(:domain).permit(:name, :url))
    authorize @domain 
    if @domain.save
      flash[:notice] = "Domain was saved succesfully."
      redirect_to @domain
    else
      flash[:error] = "There was an error saving the domain. Please try again."
      render :new
    end
  end

  def edit
    @domain = current_user.domains.find(params[:id])
    authorize @domain 
  end

  def update
    @domain = current_user.domains.find(params[:id])
    authorize @domain 
    if @domain.update_attributes(params.require(:domain).permit(:name,:url))
      flash[:notice] = "Domain was updated"
      redirect_to @domain
    else
      flash[:error] = "There was an error updating it. Please try again."
      render :edit
    end
  end

end
