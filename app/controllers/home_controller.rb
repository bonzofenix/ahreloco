class HomeController < ApplicationController
  skip_before_filter :authenticate_user!, only: :index 

  def index
    @latest_program_videos = Program.latest_videos
    @top_today = Video.top_today.limit(10)
    @top_week = Video.top_week.limit(10)
    @top_month = Video.top_month.limit(10)
    @week_conquest = arl_manager.week_videos
  end
end
