# app/controllers/timelines_controller.rb
class TimelinesController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  def show
    @posts = current_user.timeline_posts(
      page: params[:page] || 1,
      per_page: params[:per_page] || 20
    )
    @user = current_user

    respond_to do |format|
      format.html { render :show }
      format.json { render json: @posts }
    end
  end
end