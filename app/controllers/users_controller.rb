class UsersController < ApplicationController
  before_filter :is_admin,:only => [:index]
  before_filter :is_login,:except => [:facebook]
  def facebook
    auth = request.env['omniauth.auth']
    user = User.create_from_omniauth(auth)
    if user
      flash[:notice] = "Signed in successfully."
      sign_in_and_redirect user, :event => :authentication
    else
      flash[:notice] = "Login failed."
      redirect_to new_user_registration_url
    end
  end
  
  def index
    @users = User.where(:role => 'user')
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to root_path
    else
      render :action => :edit
    end
  end
  
  def approve
    @user = User.find(params[:id])
    @user.approved = params[:status]
    @status = @user.approved == true ? "Approved" : "Not Approved"
    @user.save
    render
  end
  
  private
  def user_params
    params.require(:user).permit!
  end
end
