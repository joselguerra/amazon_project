class WelcomeController < ApplicationController

  def index

  end

  def contact

  end

  def submit
    @name = params[:name]
    # @email = params[:email]
    # @message = params[:message]
    render :contact
  end

  def about

  end

end
