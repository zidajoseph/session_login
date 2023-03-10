class SessionsController < ApplicationController
    skip_before_action :login_required, only: [:new, :create]

    def new
    end

    def create
        user = User.find_by(email: params[:session][:email].downcase)
        if user && user.authenticate(params[:session][:password])
          log_in(user)
          redirect_to user_path(user.id)
        else
          flash[:danger] = "Je n'ai pas réussi à me connecter"
          render :new
        end
      end

    def destroy
        session.delete(:user_id)
        flash[:notice] = "Vous avez été déconnecté."
        redirect_to new_session_path
    end

end
