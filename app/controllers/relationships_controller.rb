class RelationshipsController < ApplicationController
  before_action :logged_in_user
  before_action :find_following, only: :destroy
  before_action :find_user, only: [:index, :create]
  
  def index
    relationship = params[:relationship]
    @title = relationship
    @users = @user.send(relationship).paginate page: params[:page],
      per_page: Settings.per_page
  end

  def create
    current_user.follow @user
    relationship @user
    respond_to do |format|
      format.html {redirect_to @user}
      format.js
    end
  end

  def destroy
    current_user.unfollow @user
    respond_to do |format|
      format.html {redirect_to @user}
      format.js
    end
  end

  private
  def relationship user
    @relationship = current_user.active_relationships.find_by followed_id: user.id
  end

  def find_user
    @user = if params[:followed_id].present?
      User.find_by id: params[:followed_id]
    else
      User.find_by id: params[:user_id]
    end
    unless @user
      flash[:danger] = "User not exist"
      redirect_to users_path
    end
  end

  def find_following
    @relationship = Relationship.find_by id: params[:id]
    if @relationship
      @user = @relationship.followed
    else
      flash[:danger] = "Relationship not exist"
      redirect_to users_path
    end
  end
end
