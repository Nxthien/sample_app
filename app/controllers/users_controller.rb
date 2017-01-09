class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update]
  before_action :find_user, except: [:new, :index, :create]
  before_action :admin_user, only: [:destroy]

  def index
    @users = User.paginate page: params[:page], per_page: Settings.per_page
  end

  def new
    @user = User.new
  end

  def show
    @microposts = @user.microposts.paginate page: params[:page],
      per_page: Settings.per_page
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = "Email sent with password reset instructions"
      redirect_to root_url
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      flash[:danger] = "Update Failed"
      redirect_to :edit
    end
  end

  def destroy
    @user.destroy
    flash[:success] = "Deleted User"
  end

  private
  def user_params
    params.require(:user).permit :name, :email,
      :password, :password_confirmation, :image
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end

  def find_user
    @user = User.find_by id: params[:id]
    unless @user
      flash[:danger] = "User not exist"
      redirect_to users_path
    end
  end
end
