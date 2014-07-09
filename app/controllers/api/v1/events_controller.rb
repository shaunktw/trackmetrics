class Api::V1::EventsController < Api::BaseController

  def create
    respond_with({message: "ok"}, location: nil)
  end

end