class VerificationsController < ApplicationController

  def create
    @domain = Domain.find(params[:domain_id]) 
    @doc = Nokogiri::HTML(HTTParty.get(@domain.url).parsed_response)
    if @verification_code = @doc.at_xpath("//meta[@name ='trackmetrics_verification']")
      keyword = @verification_code["content"]
      if keyword == @domain.verification_token
        @domain.verify!
        flash[:notice] = "Your domain has been verified!"
      else
        flash[:error] = "Incorrect verification"
      end

      redirect_to domain_url(@domain)
    else
      redirect_to domain_url(@domain), error: "Incorrect verification"
    end

  end

end
