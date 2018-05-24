class ToppagesController < ApplicationController
  def index
    if logged_in?
      @user = current_user
      @tasks = current_user.tasks.all
    end
  end
end