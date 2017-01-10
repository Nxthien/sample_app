class StaticPagesController < ApplicationController
  before_action :load_feeds, only: :home

  def home
  end

  def help
  end

  def about
  end

  def contact
  end
  private
  def load_feeds
    if logged_in?
      @micropost = current_user.microposts.build
      @feed_items = current_user.feeds.order(id: :desc)
        .paginate page: params[:page], per_page: Settings.per_page
    end
  end
end
