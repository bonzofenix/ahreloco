class HomeController < ApplicationController
  def index
    @carrousel = Program.latest_videos
    @top_today = Video.from_community.top_today.limit(10)
    @top_week = Video.from_community.top_week.limit(10)
    @top_month = Video.from_community.top_month.limit(10)
    @top_today_programs = Video.with_program.top_today.limit(10)
    @top_week_programs = Video.with_program.top_week.limit(10)
    @top_month_programs = Video.with_program.top_month.limit(10)
    @week_conquest = arl_manager.week_videos
    @videos = Video.latest_published.from_community.paginate(page: params[:page])
  end
end
