class StaticPagesController < ApplicationController

  def home
  	@user = current_user
  	@feed_items = current_user.feed
  	@micropost = current_user.microposts.new if signed_in?
  end

  def help
  end

  def about
  end

end
