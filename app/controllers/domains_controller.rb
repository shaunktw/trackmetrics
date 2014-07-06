class DomainsController < ApplicationController

  before_filter :authenticate_user!

  def index
    @domains = current_user.domains
  end

  def show
    @domain = current_user.domains.find(params[:id])
  end

  def new
    @domain = current_user.domains.build
  end

  def create
    @domain = current_user.domains.build(params.require(:domain).permit(:name, :url))
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
  end

  def update
    @domain = current_user.domains.find(params[:id])
    if @domain.update_attributes(params.require(:domain).permit(:name,:url))
      flash[:notice] = "Domain was updated"
      redirect_to @domain
    else
      flash[:error] = "There was an error updating it. Please try again."
      render :edit
    end
  end

end
