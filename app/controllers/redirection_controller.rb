class RedirectionController < ApplicationController

  # The routes to redirect the user into a new url
  # Permits to set goals in google tag manager and anlytics
  def go
    # Define the redirection URL in the params
    @url = params[:url]
  end
end
