class UsernamesController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :redirect_to_username_form
  def new 
  end
 
  def update
    if username_params[:username].present? && current_user.update(username_params)
      flash[:notice] = 'username successfully update'
      redirect_to dashboard_path
    else
      flash[:alert] = if username_params[:username].blank?
                        'please set a username'
                      else
                        current_user.errors.full_messages.to_sentence
                      end
      redirect_to new_username_path
    end
  end

  private

  def username_params
    params.require(:user).permit(:username, :name, :avatar)
  end
end