class SessionsController < ApplicationController
  def new
  end

  def create
    # we have the user's email & password from the params
    # 1. find the user by their email
    # 2. if found, we authenticate the user with the given password
    # 3. if not found, we alert the user with wrong credentials

    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to home_path, notice: 'Thank you for signing in! â¤ï¸'
    else
      # `flash.now` makes the flash message available to the current request
      # as opposed to next request with just `flash`
      flash.now[:alert] = 'Wrong credentials! ð«'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to home_path, notice: 'Signed Out! ð'
  end
end
