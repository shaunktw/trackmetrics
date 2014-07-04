class DomainsController < ApplicationController
  def index
    @domains = Domain.all
  end

  def show
    @domain = Domain.find(params[:id])
  end

  def new
    @domain = Domain.new
  end

  def create
    @domain = Domain.new(params.require(:domain).permit(:name, :url, :domain_uuid))
    if @domain.save
      flash[:notice] = "Domain was saved succesfully."
      redirect_to @domain
    else
      flash[:error] = "There was an error saving the domain. Please try again."
      render :new
    end
  end

  def edit
    @domain = Domain.find(params[:id])
  end

  def update
    @domain = Domain.find(params[:id])
    if @domain.update_attributes(params.require(:domain).permit(:name,:url), :domain_uuid)
      flash[:notice] = "Domain was updated"
      redirect_to @domain
    else
      flash[:error] = "There was an error updating it. Please try again."
      render :edit
    end
  end

end
