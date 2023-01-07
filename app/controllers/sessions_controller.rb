class SessionsController < ApplicationController
  def new
  end

  def create
    @app_session = User.create_app_session(
      email: login_params[:email],
      password: login_params[:password]
    )

    if @app_session
      # TODO: Store data in cookie

      flash[:success] = t(".success")
      redirect_to root_path, status: :see_other
    else
      flash.now[:danger] = t(".incorrect_details")
      render :new, status: :unprocessable_entity
    end
  end

  private

  def login_params
    @login_params ||=
      params.require(:user).permit(:email, :password)
  end
end
